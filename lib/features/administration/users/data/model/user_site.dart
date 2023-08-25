
import '/common_libraries.dart';

class UserSite extends Entity {
  final String siteId;
  final String siteName;
  final bool isDefault;
  bool isAssigned;
  UserSite({
    super.id,
    required this.siteId,
    required this.siteName,
    required this.isDefault,
    required this.isAssigned,
    super.createdByUserName,
    super.createdOn,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        siteId,
        siteName,
        isDefault,
        isAssigned,
      ];

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Site Name': siteName,
      'Access granted by': createdByUserName,
      'Access granted on': createdOn,
    };
  }

  UserSite copyWith({
    String? id,
    String? siteId,
    String? siteName,
    bool? isDefault,
    bool? isAssigned,
    String? createdOn,
    String? createdByUserName,
  }) {
    return UserSite(
      id: id ?? this.id,
      siteId: siteId ?? this.siteId,
      siteName: siteName ?? this.siteName,
      isDefault: isDefault ?? this.isDefault,
      isAssigned: isAssigned ?? this.isAssigned,
      createdByUserName: createdByUserName ?? this.createdByUserName,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  factory UserSite.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return UserSite(
      id: entity.id,
      siteId: map['siteId'] as String,
      siteName: map['siteName'] as String,
      isDefault: map['isDefault'] as bool,
      isAssigned: map['isAssigned'] as bool,
      createdByUserName: entity.createdByUserName,
      createdOn: entity.createdOn,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSite.fromJson(String source) =>
      UserSite.fromMap(json.decode(source) as Map<String, dynamic>);
}
