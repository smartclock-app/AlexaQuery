part 'queue_type.dart';

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

class Memory {
  final DateTime? updatedDateTime;
  final String? value;

  Memory({
    this.updatedDateTime,
    this.value,
  });

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        updatedDateTime: json["updatedDateTime"] == null ? null : DateTime.parse(json["updatedDateTime"]),
        value: json["value"],
      );
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
}
