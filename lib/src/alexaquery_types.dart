// Devices
class Device {
  final String accountName;
  final String deviceType;
  final String serialNumber;
  final String deviceFamily;

  Device({
    required this.accountName,
    required this.deviceType,
    required this.serialNumber,
    required this.deviceFamily,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      accountName: json['accountName'],
      deviceType: json['deviceType'],
      serialNumber: json['serialNumber'],
      deviceFamily: json['deviceFamily'],
    );
  }

  @override
  String toString() {
    return "Device(accountName: $accountName, deviceType: $deviceType, serialNumber: $serialNumber, deviceFamily: $deviceFamily)";
  }
}

// Notifications
class Notification {
  final String? alarmLabel;
  final int? alarmTime;
  final int? createdDate;
  final String? deferredAtTime;
  final String? deviceName;
  final String? deviceSerialNumber;
  final String? id;
  final int? lastOccurrenceTimeInMilli;
  final String? lastTriggerTimeInUtc;
  final int? lastUpdatedDate;
  final int? loopCount;
  final String? originalDate;
  final int? originalDurationInMillis;
  final String? originalTime;
  final int? remainingTime;
  final String? reminderLabel;
  final String? snoozedToTime;
  final String? status;
  final String? timerLabel;
  final int? triggerTime;
  final String? type;

  Notification({
    required this.alarmLabel,
    required this.alarmTime,
    required this.createdDate,
    required this.deferredAtTime,
    required this.deviceName,
    required this.deviceSerialNumber,
    required this.id,
    required this.lastOccurrenceTimeInMilli,
    required this.lastTriggerTimeInUtc,
    required this.lastUpdatedDate,
    required this.loopCount,
    required this.originalDate,
    required this.originalDurationInMillis,
    required this.originalTime,
    required this.remainingTime,
    required this.reminderLabel,
    required this.snoozedToTime,
    required this.status,
    required this.timerLabel,
    required this.triggerTime,
    required this.type,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      alarmLabel: json['alarmLabel'],
      alarmTime: json['alarmTime'],
      createdDate: json['createdDate'],
      deferredAtTime: json['deferredAtTime'],
      deviceName: json['deviceName'],
      deviceSerialNumber: json['deviceSerialNumber'],
      id: json['id'],
      lastOccurrenceTimeInMilli: json['lastOccurrenceTimeInMilli'],
      lastTriggerTimeInUtc: json['lastTriggerTimeInUtc'],
      lastUpdatedDate: json['lastUpdatedDate'],
      loopCount: json['loopCount'],
      originalDate: json['originalDate'],
      originalDurationInMillis: json['originalDurationInMillis'],
      originalTime: json['originalTime'],
      remainingTime: json['remainingTime'],
      reminderLabel: json['reminderLabel'],
      snoozedToTime: json['snoozedToTime'],
      status: json['status'],
      timerLabel: json['timerLabel'],
      triggerTime: json['triggerTime'],
      type: json['type'],
    );
  }

  @override
  String toString() {
    return "Notification(alarmLabel: $alarmLabel, alarmTime: $alarmTime, deviceName: $deviceName, originalDate: $originalDate, originalDurationInMillis: $originalDurationInMillis, originalTime: $originalTime, remainingTime: $remainingTime, reminderLabel: $reminderLabel, snoozedToTime: $snoozedToTime, status: $status, timerLabel: $timerLabel, triggerTime: $triggerTime, type: $type)";
  }
}

// Queue
class PlayerInfo {
  final InfoText? infoText;
  final MainArt? mainArt;
  final Progress? progress;
  final Provider? provider;
  final String? state;

  PlayerInfo({
    this.infoText,
    this.mainArt,
    this.progress,
    this.provider,
    this.state,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) {
    return PlayerInfo(
      infoText: InfoText.fromJson(json['infoText']),
      mainArt: MainArt.fromJson(json['mainArt']),
      progress: Progress.fromJson(json['progress']),
      provider: Provider.fromJson(json['provider']),
      state: json['state'],
    );
  }

  factory PlayerInfo.empty() {
    return PlayerInfo(
      infoText: InfoText(subText1: null, title: null),
      mainArt: MainArt(url: null),
      progress: Progress(mediaLength: null, mediaProgress: null),
      provider: Provider(providerName: null),
      state: null,
    );
  }

  @override
  String toString() {
    return "PlayerInfo(infoText: $infoText, mainArt: $mainArt, progress: $progress, provider: $provider, state: $state)";
  }
}

class InfoText {
  final String? subText1;
  final String? title;

  InfoText({this.subText1, this.title});

  factory InfoText.fromJson(Map<String, dynamic> json) {
    return InfoText(
      subText1: json['subText1'],
      title: json['title'],
    );
  }

  @override
  String toString() {
    return "InfoText(subText1: $subText1, title: $title)";
  }
}

class MainArt {
  final String? url;

  MainArt({this.url});

  factory MainArt.fromJson(Map<String, dynamic> json) {
    return MainArt(
      url: json['url'],
    );
  }

  @override
  String toString() {
    return "MainArt(url: $url)";
  }
}

class Progress {
  final int? mediaLength;
  final int? mediaProgress;

  Progress({this.mediaLength, this.mediaProgress});

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      mediaLength: json['mediaLength'],
      mediaProgress: json['mediaProgress'],
    );
  }

  @override
  String toString() {
    return "Progress(mediaLength: $mediaLength, mediaProgress: $mediaProgress)";
  }
}

class Provider {
  final String? providerName;

  Provider({this.providerName});

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      providerName: json['providerName'],
    );
  }

  @override
  String toString() {
    return "Provider(providerName: $providerName)";
  }
}
