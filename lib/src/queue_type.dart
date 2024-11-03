part of "alexaquery_types.dart";

class Queue {
  InfoText? infoText;
  MainArt? mainArt;
  MediaReference? mediaReference;
  String? playerState;
  Progress? progress;
  Provider? provider;
  DateTime? timestamp;

  Queue({this.infoText, this.mainArt, this.mediaReference, this.playerState, this.progress, this.provider, this.timestamp});

  factory Queue.fromJson(Map<String, dynamic> json, DateTime timestamp) => Queue(
        infoText: json["infoText"] == null ? null : InfoText.fromJson(json["infoText"]),
        mainArt: json["mainArt"] == null ? null : MainArt.fromJson(json["mainArt"]),
        mediaReference: json["mediaReference"] == null ? null : MediaReference.fromJson(json["mediaReference"]),
        playerState: json["playerState"],
        progress: json["progress"] == null ? null : Progress.fromJson(json["progress"]),
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
        timestamp: timestamp,
      );
}

class EndpointList {
  Id? id;

  EndpointList({
    this.id,
  });

  factory EndpointList.fromJson(Map<String, dynamic> json) => EndpointList(
        id: json["id"] == null ? null : Id.fromJson(json["id"]),
      );
}

class Id {
  String? deviceSerialNumber;
  String? deviceType;
  dynamic softwareVersion;

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
}

class InfoText {
  String? subText1;
  String? subText2;
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
}

class MainArt {
  String? fullUrl;

  MainArt({
    this.fullUrl,
  });

  factory MainArt.fromJson(Map<String, dynamic> json) => MainArt(
        fullUrl: json["fullUrl"],
      );
}

class MediaReference {
  String? value;

  MediaReference({
    this.value,
  });

  factory MediaReference.fromJson(Map<String, dynamic> json) => MediaReference(
        value: json["value"],
      );
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
}

class Provider {
  ProviderLogo? providerLogo;
  String? providerName;

  Provider({
    this.providerLogo,
    this.providerName,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        providerLogo: json["providerLogo"] == null ? null : ProviderLogo.fromJson(json["providerLogo"]),
        providerName: json["providerName"],
      );
}

class ProviderLogo {
  String? altText;
  String? url;

  ProviderLogo({
    this.altText,
    this.url,
  });

  factory ProviderLogo.fromJson(Map<String, dynamic> json) => ProviderLogo(
        altText: json["altText"],
        url: json["url"],
      );
}
