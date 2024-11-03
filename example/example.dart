import 'dart:convert';
import 'dart:io';
import 'package:alexaquery_dart/alexaquery_dart.dart';

void main() async {
  final alexaQuery = QueryClient(
    File('cookies.txt'),
    logger: (log, level) => print("$level: $log"),
    loginToken: "",
  );
  // var devices = await alexaQuery.getDevices("testuser");
  // print(devices);

  // final memories = await alexaQuery.getMemories("testuser");
  // print(jsonEncode(memories));

  final queue = await alexaQuery.getQueue("testuser", "Bedroom Pop");
  print(jsonEncode(queue));
}
