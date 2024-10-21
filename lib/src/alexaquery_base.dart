import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:mutex/mutex.dart';
import 'alexaquery_types.dart';

class QueryClient {
  static final String _browser = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:1.0) bash-script/1.0";
  late final Map<String, String> _cookies;
  String _csrf = "";
  late final Dio _client;
  late final File _cookieFile;
  final Mutex _mutex = Mutex();
  String? loginToken;
  DateTime? lastSucessfulLogin;

  /// Logger function.
  /// By default, it prints logs to the console with the format: `AlexaQuery[$level]: $log`.
  /// To disable logging, set this to an empty function.
  Function(String log, String level) _logger = (String log, String info) => print("AlexaQuery[$info]: $log");

  /// Creates a new [QueryClient] instance.
  QueryClient(this._cookieFile, {Function(String log, String level)? logger, this.loginToken}) {
    if (logger != null) _logger = logger;
    if (!_cookieFile.existsSync()) _cookieFile.createSync();
    try {
      final cookies = _cookieFile.readAsStringSync();
      _logger("Loading cookies from '${_cookieFile.absolute.path}'", "info");
      if (cookies.isNotEmpty) {
        _cookies = jsonDecode(cookies).cast<String, String>();
      } else {
        _logger("'${_cookieFile.absolute.path}' empty", "info");
        _cookies = {};
      }
    } catch (e) {
      _logger("Error loading cookies from '${_cookieFile.absolute.path}': $e", "warn");
      _cookies = {};
    }

    _client = Dio(BaseOptions(
      followRedirects: true,
      validateStatus: (status) {
        return true;
      },
    ));
  }

  String _parseCookiesFromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> cookiesMap = json['response']['tokens']['cookies'];

    String cookies = "";
    for (final domain in cookiesMap.keys) {
      for (final cookieData in cookiesMap[domain]!) {
        // Remove leading and trailing quotes and spaces from cookie value
        String cookieValue = (cookieData['Value'] as String).replaceAll(RegExp(r'^[" ]+'), "").replaceAll(RegExp(r'[" ]$'), "");

        cookies += "${cookieData['Name']}=$cookieValue; ";
      }
    }

    return cookies;
  }

  /// Checks the status of the user with the given [userId].
  ///
  /// Returns a [Future] that resolves to a [bool] indicating whether the user is logged in.
  Future<bool> _checkStatus(String userId) async {
    var response = await _client.get(
      "https://alexa.amazon.co.uk/api/bootstrap?version=0",
      options: Options(
        headers: {
          "DNT": "1",
          "User-Agent": _browser,
          "Cookie": _cookies[userId],
        },
      ),
    );

    return response.statusCode == 200;
  }

  /// Retrieves Amazon cookie using [token].
  /// If [token] is not provided, it will use the token provided during the initialization of the client.
  ///
  /// Checks if the user is already logged in before proceeding.
  ///
  /// Throws an [Exception] if a CSRF token is not found during the process.
  /// Throws an [Exception] if both [token] and [QueryClient.loginToken] are null.
  /// Otherwise, returns a [Future] that resolves to a [bool] indicating whether the login was successful.
  Future<bool?> login(String userId, String? token) async {
    final now = DateTime.now();

    final status = await _mutex.protect(() async {
      if (lastSucessfulLogin != null) {
        final diff = now.difference(lastSucessfulLogin!);
        if (diff.inSeconds < 15) {
          return true;
        }
      }

      if (await _checkStatus(userId)) {
        _logger("Check Status: $userId logged in", 'trace');
        lastSucessfulLogin = now;
        return true;
      } else {
        return false;
      }
    });

    if (status == true) {
      return true;
    }

    if (token == null && loginToken != null) {
      token = loginToken;
    } else {
      if (token == null) {
        throw Exception("No token provided");
      }
    }

    _logger("Logging in user: $userId", 'trace');

    final response = await _client.post(
      "https://api.amazon.co.uk/ap/exchangetoken/cookies",
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "x-amzn-identity-auth-domain": "api.amazon.co.uk",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
      data: {
        "app_name": "Amazon Alexa",
        "requested_token_type": "auth_cookies",
        "domain": "www.amazon.co.uk",
        "source_token_type": "refresh_token",
        "source_token": token,
      },
    );

    if (response.statusCode != 200) {
      _logger("Login failed with status code: ${response.statusCode}", 'warn');
      return false;
    }

    _cookies[userId] = _parseCookiesFromJson(response.data);

    List<String> csrfUrls = [
      "https://alexa.amazon.co.uk/api/language",
      "https://alexa.amazon.co.uk/templates/oobe/d-device-pick.handlebars",
      "https://alexa.amazon.co.uk/api/devices-v2/device?cached=false",
    ];

    bool csrfTokenExists = false;

    for (String url in csrfUrls) {
      final response = await _client.get(
        url,
        options: Options(
          headers: {
            "DNT": 1,
            "Connection": "keep-alive",
            "Referer": "https://alexa.amazon.co.uk/spa/index.html",
            "Origin": "https://alexa.amazon.co.uk",
            "Cookie": _cookies[userId]!,
          },
        ),
      );

      if (response.headers["set-cookie"] != null && response.headers["set-cookie"]!.join("; ").contains("csrf=")) {
        final csrf = response.headers["set-cookie"]![0].split(" ")[0];
        _cookies[userId] = _cookies[userId]! + csrf;
        _csrf = csrf.split("=")[1];
        csrfTokenExists = true;
        break;
      }

      if (csrfTokenExists) break;
    }

    if (!csrfTokenExists) {
      throw Exception("CSRF Token not found");
    }

    _cookieFile.writeAsStringSync(jsonEncode(_cookies), mode: FileMode.writeOnly);

    lastSucessfulLogin = now;
    return true;
  }

  /// Retrieves a list of devices associated with the specified user ID.
  ///
  /// Throws an [Exception] if the user is not logged in.
  /// Otherwise, returns a [Future] that resolves to a list of [Device] objects.
  Future<List<Device>> getDevices(String userId) async {
    final isLoggedIn = await login(userId, null);
    if (!isLoggedIn!) throw Exception("User not logged in");

    final response = await _client.get("https://alexa.amazon.co.uk/api/devices-v2/device?cached=false",
        options: Options(
          headers: {
            "DNT": "1",
            "Referer": "https://alexa.amazon.co.uk/spa/index.html",
            "Origin": "https://alexa.amazon.co.uk",
            "Cookie": _cookies[userId],
            "csrf": _csrf,
          },
        ));

    // const List<String> deviceFamilies = ["ECHO", "ROOK", "KNIGHT"];

    final List<Device> devices = (response.data["devices"] as List<dynamic>)
        // .where((device) {
        //   return deviceFamilies.contains(device["deviceFamily"]);
        // })
        .map((device) => Device(
              accountName: device['accountName']!,
              deviceFamily: device['deviceFamily']!,
              deviceType: device['deviceType']!,
              serialNumber: device['serialNumber']!,
              parentClusters: device['parentClusters'] == null ? [] : List<String>.from(device['parentClusters']),
            ))
        .toList();

    devices.sort((a, b) => a.accountName.compareTo(b.accountName));
    return devices;
  }

  /// Retrieves a list of notifications associated with the specified user ID.
  ///
  /// Throws an [Exception] if the user is not logged in.
  /// Otherwise, returns a [Future] that resolves to a list of [Notification] objects.
  Future<List<Notification>> getNotifications(String userId) async {
    // if (_cookies[userId] == null) throw Exception("User not logged in");
    final isLoggedIn = await login(userId, null);
    if (!isLoggedIn!) throw Exception("User not logged in");

    final response = await _client.get("https://alexa.amazon.co.uk/api/notifications",
        options: Options(
          headers: {
            "DNT": "1",
            "User-Agent": _browser,
            "Referer": "https://alexa.amazon.co.uk/spa/index.html",
            "Origin": "https://alexa.amazon.co.uk",
            "Content-Type": "application/json; charset=UTF-8",
            "Cookie": _cookies[userId],
            "csrf": _csrf,
          },
        ));

    return (response.data["notifications"] as List<dynamic>).map<Notification>((notification) => Notification.fromJson(notification)).toList();
  }

  /// Retrieves the player queue associated with the specified user ID.
  ///
  /// [deviceName] can be obtained from the [Device] object.
  ///
  /// Includes a timestamp from the Date header in UTC.
  ///
  /// Throws an [Exception] if the user is not logged in.
  /// Otherwise, returns a [Future] that resolves to a [Queue] object.
  Future<Queue> getQueue(String userId, String deviceName) async {
    final isLoggedIn = await login(userId, null);
    if (!isLoggedIn!) throw Exception("User not logged in");

    final devices = await getDevices(userId);
    final device = devices.firstWhere((device) => device.accountName == deviceName, orElse: () => Device.empty());
    if (device.isEmpty) return Queue.empty();

    String parent = "";
    final parentId = device.parentClusters.isNotEmpty ? device.parentClusters.first : null;
    if (parentId != null) {
      final parentDevice = devices.firstWhere((device) => device.serialNumber == parentId);
      parent = "&lemurId=$parentId&lemurDeviceType=${parentDevice.deviceType}";
    }

    final url = "https://alexa.amazon.co.uk/api/np/player?deviceSerialNumber=${device.serialNumber}&deviceType=${device.deviceType}$parent";
    final response = await _client.get(url,
        options: Options(
          headers: {
            "DNT": "1",
            "User-Agent": _browser,
            "Referer": "https://alexa.amazon.co.uk/spa/index.html",
            "Origin": "https://alexa.amazon.co.uk",
            "Content-Type": "application/json; charset=UTF-8",
            "Cookie": _cookies[userId],
            "csrf": _csrf,
          },
        ));

    DateTime timestamp = HttpDate.parse(response.headers.value("Date")!);

    if (response.data["playerInfo"] == null || response.data["playerInfo"]['state'] == null) {
      return Queue.empty();
    }

    return Queue.fromJson(response.data["playerInfo"], timestamp);
  }
}
