// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/model.dart';

class Region extends Entity implements Equatable {
  final String? name;
  final List<TimeZone> timeZones;
  final bool active;
  final int? associatedSitesCount;
  Region({
    required super.id,
    required this.name,
    required this.timeZones,
    required this.active,
    this.associatedSitesCount,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Region Name': name,
      'Time Zones Associated': timeZones,
      'Active': active,
    };
  }

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Region Name': name,
      'Time Zones Associated': timeZones.map((e) => e.name).toList(),
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        name,
        timeZones,
        active,
        associatedSitesCount!,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  Region copyWith({
    String? id,
    String? name,
    List<TimeZone>? timeZones,
    bool? active,
    int? associatedSitesCount,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
      timeZones: timeZones ?? this.timeZones,
      active: active ?? this.active,
      associatedSitesCount: associatedSitesCount ?? this.associatedSitesCount,
    );
  }

  @override
  Map<String, EntityInputType> inputTypesToMap() {
    return <String, EntityInputType>{
      'Region': EntityInputType.singleSelect,
      'Timezone': EntityInputType.multiSelect,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'timeZones': timeZones.map((x) => x.toMap()).toList(),
      'active': active,
      'associatedSitesCount': associatedSitesCount,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      timeZones: List.from(map['timeZones'])
          .map(
            (e) => TimeZone.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      active: map['active'] as bool,
      associatedSitesCount: map['associatedSitesCount'] != null
          ? map['associatedSitesCount'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
