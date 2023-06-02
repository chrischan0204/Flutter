import '/common_libraries.dart';

class UserSiteNotificationSetting extends Equatable {
  final String siteId;
  final String userId;
  final List<ObservationType> observationTypes;
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
}
