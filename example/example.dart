import 'dart:io';
import 'package:alexaquery_dart/alexaquery_dart.dart';

void main() async {
  final alexaQuery = QueryClient(File('cookies.txt'));
  var devices = await alexaQuery.getDeviceList("testuser");
  print(devices[2]);
  var _ = await alexaQuery.getQueue("testuser", devices[2].serialNumber, devices[2].deviceType);
}
