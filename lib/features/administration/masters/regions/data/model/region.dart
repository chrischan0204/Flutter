import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/model.dart';

class Region extends Entity implements Equatable {
  final List<TimeZone> timeZones;

  final int? siteCount;
  const Region({
    super.id,
    this.timeZones = const [],
    super.active,
    super.name,
    this.siteCount,
    super.deactivationDate,
    super.deactivationUserName,
  });

  bool get deletable => siteCount == 0 || siteCount == null;

  List<TimeZone> get associatedTimeZones =>
      timeZones.where((timeZone) => timeZone.assigned).toList();

  @override
  Map<String, dynamic> detailItemsToMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'Region Name': name,
      'Time Zones Associated': timeZones
          .where((timeZone) => timeZone.assigned)
          .map((timeZone) => timeZone.name)
          .toList(),
    };

    return map..addEntries(super.detailItemsToMap().entries);
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
        id,
        name,
        timeZones,
        active,
        siteCount,
        deactivationDate,
        deactivationUserName,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  Region copyWith({
    String? id,
    String? name,
    List<TimeZone>? timeZones,
    bool? active,
    int? siteCount,
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return Region(
      id: id ?? this.id,
      name: name ?? this.name,
      timeZones: timeZones ?? this.timeZones,
      active: active ?? this.active,
      siteCount: siteCount ?? this.siteCount,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'name': name,
      'timeZones': timeZones.map((x) => x.toMap()).toList(),
      'active': active,
    };
    return map;
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Region(
      id: entity.id,
      name: entity.name,
      timeZones: List.from(map['timeZones'])
          .map(
            (e) => TimeZone.fromMap(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
      siteCount: map['siteCount'] != null ? map['siteCount'] as int : null,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
