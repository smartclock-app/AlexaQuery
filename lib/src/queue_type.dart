part of "alexaquery_types.dart";

class Queue {
  final InfoText? infoText;
  final MainArt? mainArt;
  final MediaReference? mediaReference;
  final String? playerState;
  final Progress? progress;
  final Provider? provider;
  final String? timestamp;

  Queue({this.infoText, this.mainArt, this.mediaReference, this.playerState, this.progress, this.provider, this.timestamp});

  factory Queue.fromJson(Map<String, dynamic> json, DateTime timestamp) => Queue(
        infoText: json["infoText"] == null ? null : InfoText.fromJson(json["infoText"]),
        mainArt: json["mainArt"] == null ? null : MainArt.fromJson(json["mainArt"]),
        mediaReference: json["mediaReference"] == null ? null : MediaReference.fromJson(json["mediaReference"]),
        playerState: json["playerState"],
        progress: json["progress"] == null ? null : Progress.fromJson(json["progress"]),
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
        timestamp: timestamp.toIso8601String(),
      );

  Map<String, dynamic> toJson() => {
        "infoText": infoText?.toJson(),
        "mainArt": mainArt?.toJson(),
        "mediaReference": mediaReference?.toJson(),
        "playerState": playerState,
        "progress": progress?.toJson(),
        "provider": provider?.toJson(),
        "timestamp": timestamp
      };
}

class EndpointList {
  final Id? id;

  EndpointList({
    this.id,
  });

  factory EndpointList.fromJson(Map<String, dynamic> json) => EndpointList(
        id: json["id"] == null ? null : Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id?.toJson(),
      };
}

class Id {
  final String? deviceSerialNumber;
  final String? deviceType;
  final dynamic softwareVersion;

  Id({
    this.deviceSerialNumber,
    this.deviceType,
    this.softwareVersion,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        deviceSerialNumber: json["deviceSerialNumber"],
        deviceType: json["deviceType"],
        softwareVersion: json["softwareVersion"],
      );

  Map<String, dynamic> toJson() => {
        "deviceSerialNumber": deviceSerialNumber,
        "deviceType": deviceType,
        "softwareVersion": softwareVersion,
      };
}

class InfoText {
  final String? subText1;
  final String? subText2;
  final String? title;

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
  final String? fullUrl;

  MainArt({
    this.fullUrl,
  });

  factory MainArt.fromJson(Map<String, dynamic> json) => MainArt(
        fullUrl: json["fullUrl"],
      );

  Map<String, dynamic> toJson() => {
        "fullUrl": fullUrl,
      };
}

class MediaReference {
  final String? value;

  MediaReference({
    this.value,
  });

  factory MediaReference.fromJson(Map<String, dynamic> json) => MediaReference(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Progress {
  final int? mediaLength;
  final int? mediaProgress;

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
  final ProviderLogo? providerLogo;
  final String? providerName;

  Provider({
    this.providerLogo,
    this.providerName,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        providerLogo: json["providerLogo"] == null ? null : ProviderLogo.fromJson(json["providerLogo"]),
        providerName: json["providerName"],
      );

  Map<String, dynamic> toJson() => {
        "providerLogo": providerLogo?.toJson(),
        "providerName": providerName,
      };
}

class ProviderLogo {
  final String? altText;
  final String? url;

  ProviderLogo({
    this.altText,
    this.url,
  });

  factory ProviderLogo.fromJson(Map<String, dynamic> json) => ProviderLogo(
        altText: json["altText"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "altText": altText,
        "url": url,
      };
}
