# Alexa Query

A Dart library for querying Alexa devices.

## API Reference

All client methods return a Future.

#### Initialize Query Client

```dart
import "package:alexaquery_dart/alexaquery.dart";
final client = QueryClient(File("cookies.json"));
```

#### Check Login Status

```dart
bool isLoggedIn = await client.checkStatus(userId);
```

#### Login

```dart
bool loginSuccessful = await client.login(userId, amazon_refresh_token);
```

#### Get Devices

```dart
List<Device> devices = await client.getDeviceList(userId);
for(var device in devices) {
  print(device.accountName);
}
```

#### Get Notifications

```dart
List<Notification> notifications = await client.getNotifications(userId);
for(var n in notifications) {
  print(n.type);
}
```

#### Get Queue

```dart
Device device = getDevice();
Queue queue = await client.getQueue(userId, device.accountName);
```
