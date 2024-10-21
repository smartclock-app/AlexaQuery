# Alexa Query

A Dart library for querying Alexa devices.
Designed for use with [SmartClock](https://github.com/smartclock-app/Clock)

## API Reference

All client methods return a Future.

#### Initialize Query Client

```dart
import "package:alexaquery_dart/alexaquery_dart.dart";
final client = QueryClient(
  File("cookies.json"),
  loginToken: alexa_refresh_token, // optional
  logger_function: (message, level) => print("[$level] $message"), //optional
);
```

#### Login

```dart
bool loginSuccessful = await client.login(userId, amazon_refresh_token);
```

#### Get Devices

```dart
List<Device> devices = await client.getDevices(userId);
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
List<Device> devices = await getDevices(userId);
Queue queue = await client.getQueue(userId, devices.first.accountName);
```
