# Alexa Query

A Dart library for querying Alexa devices.

## API Reference

All client methods return a Future.

#### Initialize Query Client

```dart
import "package:alexaquery_dart/alexaquery.dart";
const client = new QueryClient(File("cookies.json"));
```

#### Login

```dart
await client.login(userId, amazon_refresh_token);
```

#### Check Login Status

```dart
await client.checkStatus(userId);
```

#### Get Devices

```dart
await client.getDeviceList(userId);
```

#### Get Notifications

```dart
await client.getNotifications(userId);
```

#### Get Queue

```dart
await client.getQueue(userId, device);
```
