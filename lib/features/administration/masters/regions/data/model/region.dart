import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class Region extends Entity implements Equatable {
  final String? id;
  final String regionName;
  final List<String> timezonesAssociated;
  final bool isActive;
  final int? associatedSitesCount;
  Region({
    required this.regionName,
    required this.timezonesAssociated,
    required this.isActive,
    this.associatedSitesCount,
    this.id,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Region Name': regionName,
      'Time Zones Associated': timezonesAssociated,
      'Active': isActive,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Region Name': regionName,
      'Time Zones Associated': timezonesAssociated,
      'Active': isActive,
    };
  }

  @override
  List<Object?> get props => [
        regionName,
        timezonesAssociated,
        isActive,
        associatedSitesCount!,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  Region copyWith({
    String? regionName,
    List<String>? timezonesAssociated,
    bool? isActive,
    int? associatedSitesCount,
  }) {
    return Region(
      regionName: regionName ?? this.regionName,
      timezonesAssociated: timezonesAssociated ?? this.timezonesAssociated,
      isActive: isActive ?? this.isActive,
      associatedSitesCount: associatedSitesCount ?? this.associatedSitesCount,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'regionName': regionName,
      'timezonesAssociated': timezonesAssociated,
      'isActive': isActive,
      'associatedSitesCount': associatedSitesCount,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      regionName: map['regionName'] as String,
      timezonesAssociated:
          List<String>.from((map['timezonesAssociated'] as List<String>)),
      isActive: map['isActive'] as bool,
      associatedSitesCount: map['associatedSitesCount'] as int,
    );
  }

  @override
  Map<String, EntityInputType> inputTypesToMap() {
    return <String, EntityInputType>{
      'Region': EntityInputType.singleSelect,
      'Timezone': EntityInputType.multiSelect,
    };
  }
}
