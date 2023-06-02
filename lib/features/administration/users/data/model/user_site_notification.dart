import '/common_libraries.dart';

class UserSiteNotification extends Equatable {
  final List<ObservationTypeInfo> headers;
  final SiteNotification data;
  const UserSiteNotification({
    this.headers = const [],
    this.data = const SiteNotification(),
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  UserSiteNotification copyWith({
    List<ObservationTypeInfo>? headers,
    SiteNotification? data,
  }) {
    return UserSiteNotification(
      headers: headers ?? this.headers,
      data: data ?? this.data,
    );
  }

  factory UserSiteNotification.fromMap(Map<String, dynamic> map) {
    return UserSiteNotification(
      headers: List.from(map['headers'])
          .map((e) => ObservationTypeInfo.fromMap(e))
          .toList(),
      data: SiteNotification.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory UserSiteNotification.fromJson(String source) {
    String src =
        source.replaceAll('\\', '').replaceAll('"[', '[').replaceAll(']"', ']');
    return UserSiteNotification.fromMap(
        json.decode(src) as Map<String, dynamic>);
  }
}

class ObservationTypeInfo extends Equatable {
  final String observationTypeId;
  final String observationTypeName;
  const ObservationTypeInfo({
    required this.observationTypeId,
    required this.observationTypeName,
  });

  @override
  List<Object?> get props => [
        observationTypeId,
        observationTypeName,
      ];

  factory ObservationTypeInfo.fromMap(Map<String, dynamic> map) {
    return ObservationTypeInfo(
      observationTypeId: map['ObservationTypeId'] as String,
      observationTypeName: map['ObservationTypeName'] as String,
    );
  }

  factory ObservationTypeInfo.fromJson(String source) =>
      ObservationTypeInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
