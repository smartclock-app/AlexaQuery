import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'alexaquery_types.dart';

class QueryClient {
  static final String _browser = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:1.0) bash-script/1.0";
  late final Map<String, String> _cookies;
  String _csrf = "";
  late final Dio _client;
  late final File _cookieFile;

  /// Creates a new [QueryClient] instance.
  QueryClient(this._cookieFile) {
    try {
      final cookies = _cookieFile.readAsStringSync();
      if (cookies.isNotEmpty) {
        _cookies = jsonDecode(cookies).cast<String, String>();
        print("Loaded cookies from file");
      } else {
        _cookies = {};
      }
    } catch (e) {
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
        String cookieValue =
            (cookieData['Value'] as String).replaceAll(RegExp(r'^[" ]+'), "").replaceAll(RegExp(r'[" ]$'), "");

        cookies += "${cookieData['Name']}=$cookieValue; ";
      }
    }

    return cookies;
  }

  /// Checks the status of the user with the given [userId].
  ///
  /// Returns a [Future] that resolves to a [bool] indicating whether the user is logged in.
  Future<bool> checkStatus(String userId) async {
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
  ///
  /// Throws an [Exception] if a CSRF token is not found during the process.
  /// Otherwise, returns a [Future] that resolves to a [bool] indicating whether the login was successful.
  Future<bool?> login(String userId, String token) async {
    print("Logging in user: $userId");

    if (await checkStatus(userId)) {
      print("Already logged in");
      return true;
    }

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
      print("Login failed with status code: ${response.statusCode}");
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

    return true;
  }

  /// Retrieves a list of devices associated with the specified user ID.
  ///
  /// Returns a [Future] that resolves to a list of [Device] objects.
  Future<List<Device>> getDeviceList(String userId) async {
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

    const List<String> deviceFamilies = ["ECHO", "ROOK", "KNIGHT"];

    final List<Device> filteredDevices = (response.data["devices"] as List<dynamic>)
        .where((device) {
          return deviceFamilies.contains(device["deviceFamily"]);
        })
        .map((device) => Device(
              accountName: device['accountName']!,
              deviceFamily: device['deviceFamily']!,
              deviceType: device['deviceType']!,
              serialNumber: device['serialNumber']!,
            ))
        .toList();

    filteredDevices.sort((a, b) => a.accountName.compareTo(b.accountName));
    return filteredDevices;
  }

  /// Retrieves a list of notifications associated with the specified user ID.
  ///
  /// Returns a [Future] that resolves to a list of [Notification] objects.
  Future<List<Notification>> getNotifications(String userId) async {
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

    return (response.data["notifications"] as List<dynamic>)
        .map<Notification>((notification) => Notification.fromJson(notification))
        .toList();
  }

  /// Retrieves the player queue associated with the specified user ID.
  ///
  /// The [serialNumber] and [deviceType] parameters are used to identify the device.
  /// These can be obtained from the [Device] object.
  ///
  /// Returns a [Future] that resolves to a [PlayerInfo] object.
  Future<PlayerInfo> getQueue(String userId, String serialNumber, String deviceType) async {
    final url = "https://alexa.amazon.co.uk/api/np/player?deviceSerialNumber=$serialNumber&deviceType=$deviceType";
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

    print(response.data["playerInfo"]);

    if (response.data["playerInfo"] == null || response.data["playerInfo"]['state'] == null) {
      return PlayerInfo.empty();
    }

    return PlayerInfo.fromJson(response.data["playerInfo"]);
  }
}
