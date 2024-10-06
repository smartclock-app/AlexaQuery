import 'dart:io';
import 'package:alexaquery_dart/alexaquery_dart.dart';

void main() async {
  final alexaQuery = QueryClient(File('cookies.txt'));
  // var devices = await alexaQuery.getDeviceList("testuser");
  // print(devices[1]);
  var queue = await alexaQuery.getQueue("testuser", "Kitchen Dot");
  print(queue.infoText!.title!);
}
