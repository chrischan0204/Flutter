import '/common_libraries.dart';

class UserSiteNotificationSetting extends Equatable {
  final String siteId;
  final String userId;
  final List<UserObservationType> observationTypes;
  const UserSiteNotificationSetting({
    required this.siteId,
    required this.userId,
    required this.observationTypes,
  });

  @override
  List<Object?> get props => [
        siteId,
        userId,
        observationTypes,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'siteId': siteId,
      'userId': userId,
      'observationTypes': observationTypes.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  UserSiteNotificationSetting copyWith({
    String? siteId,
    String? userId,
    List<UserObservationType>? observationTypes,
  }) {
    return UserSiteNotificationSetting(
      siteId: siteId ?? this.siteId,
      userId: userId ?? this.userId,
      observationTypes: observationTypes ?? this.observationTypes,
    );
  }
}
