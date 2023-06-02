import '/common_libraries.dart';

class UserSiteSetting extends Equatable {
  final String siteId;
  final String siteName;
  final List<UserObservationType> observationTypes;
  const UserSiteSetting({
    required this.siteId,
    required this.siteName,
    required this.observationTypes,
  });

  bool get allSendNotification => observationTypes
      .map((e) => e.sendNotification)
      .every((element) => element);

  @override
  List<Object?> get props => [
        siteId,
        siteName,
        observationTypes,
      ];

  UserSiteSetting copyWith({
    String? siteId,
    String? siteName,
    List<UserObservationType>? observationTypes,
  }) {
    return UserSiteSetting(
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      observationTypes: observationTypes ?? this.observationTypes,
    );
  }

  factory UserSiteSetting.fromMap(Map<String, dynamic> map) {
    return UserSiteSetting(
      siteId: map['siteId'] as String,
      siteName: map['siteName'] as String,
      observationTypes: List<UserObservationType>.from(
        (map['observationTypes']).map<UserObservationType>(
          (x) => UserObservationType.fromMap(x),
        ),
      ),
    );
  }

  factory UserSiteSetting.fromJson(String source) =>
      UserSiteSetting.fromMap(json.decode(source) as Map<String, dynamic>);
}
