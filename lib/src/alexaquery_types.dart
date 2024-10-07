class Device {
  final String accountName;
  final String deviceType;
  final String serialNumber;
  final String deviceFamily;
  final List<String> parentClusters;

  Device({
    required this.accountName,
    required this.deviceType,
    required this.serialNumber,
    required this.deviceFamily,
    required this.parentClusters,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      accountName: json['accountName'],
      deviceType: json['deviceType'],
      serialNumber: json['serialNumber'],
      deviceFamily: json['deviceFamily'],
      parentClusters: json['parentClusters'] == null ? [] : List<String>.from(json['parentClusters']),
    );
  }

  @override
  String toString() {
    return "Device(accountName: $accountName, deviceType: $deviceType, serialNumber: $serialNumber, deviceFamily: $deviceFamily, parentClusters: $parentClusters)";
  }

  factory Device.empty() {
    return Device(
      accountName: "",
      deviceType: "",
      serialNumber: "",
      deviceFamily: "",
      parentClusters: [],
    );
  }

  bool get isEmpty => accountName.isEmpty || deviceType.isEmpty || serialNumber.isEmpty || deviceFamily.isEmpty;
}

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

class Queue {
  InfoText? infoText;
  MainArt? mainArt;
  Progress? progress;
  Provider? provider;
  String? state;
  DateTime? timestamp;

  Queue({
    this.infoText,
    this.mainArt,
    this.progress,
    this.provider,
    this.state,
    this.timestamp,
  });

  factory Queue.empty() => Queue(
        infoText: null,
        mainArt: null,
        progress: null,
        provider: null,
        state: null,
        timestamp: null,
      );

  factory Queue.fromJson(Map<String, dynamic> json, DateTime? timestamp) => Queue(
        infoText: json["infoText"] == null ? null : InfoText.fromJson(json["infoText"]),
        mainArt: json["mainArt"] == null ? null : MainArt.fromJson(json["mainArt"]),
        progress: json["progress"] == null ? null : Progress.fromJson(json["progress"]),
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
        state: json["state"],
        timestamp: timestamp,
      );

  Map<String, dynamic> toJson() => {
        "infoText": infoText?.toJson(),
        "mainArt": mainArt?.toJson(),
        "progress": progress?.toJson(),
        "provider": provider?.toJson(),
        "state": state,
        "timestamp": timestamp?.toIso8601String(),
      };
}

class InfoText {
  String? subText1;
  dynamic subText2;
  String? title;

  InfoText({
    this.subText1,
    this.subText2,
    this.title,
  });

  factory InfoText.fromJson(Map<String, dynamic> json) => InfoText(
        subText1: json["subText1"],
        subText2: json["subText2"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "subText1": subText1,
        "subText2": subText2,
        "title": title,
      };
}

class MainArt {
  String? url;

  MainArt({
    this.url,
  });

  factory MainArt.fromJson(Map<String, dynamic> json) => MainArt(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Progress {
  int? mediaLength;
  int? mediaProgress;

  Progress({
    this.mediaLength,
    this.mediaProgress,
  });

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        mediaLength: json["mediaLength"],
        mediaProgress: json["mediaProgress"],
      );

  Map<String, dynamic> toJson() => {
        "mediaLength": mediaLength,
        "mediaProgress": mediaProgress,
      };
}

class Provider {
  String? providerDisplayName;

  Provider({
    this.providerDisplayName,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        providerDisplayName: json["providerDisplayName"] ?? json["providerName"],
      );

  Map<String, dynamic> toJson() => {
        "providerDisplayName": providerDisplayName,
      };
}
