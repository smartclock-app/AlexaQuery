import 'dart:io';
import 'package:alexaquery_dart/alexaquery_dart.dart';

void main() async {
  final alexaQuery = QueryClient(
    File('cookies.txt'),
    logger: (log, level) => print("$level: $log"),
  );
  var devices = await alexaQuery.getDevices("testuser");
  print(devices);
}
