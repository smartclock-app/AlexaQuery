import 'dart:io';

import 'package:alexaquery/alexaquery.dart';

String? homeDirectory() {
  switch (Platform.operatingSystem) {
    case 'linux':
    case 'macos':
      return Platform.environment['HOME'];
    case 'windows':
      return Platform.environment['USERPROFILE'];
  }

  return null;
}

void main() async {
  File cookieFile = File('${homeDirectory()}/.smartclock/cookies.txt');
  cookieFile.createSync(recursive: true);
  final client = QueryClient(cookieFile);

  // Login
  await client.login(
    "testuser",
    "token",
  );

  // Get device list
  final devices = await client.getDeviceList("testuser");
  print('Devices: $devices');

  // // Get notifications
  // final notifications = await client.getNotifications("testuser");
  // print('Notifications: $notifications');

  // Get Queue
  // final queue = await client.getQueue("testuser", "G0911W1104520WVK", "A1RABVCI4QCIKC");
  // print('Queue: $queue');
}
