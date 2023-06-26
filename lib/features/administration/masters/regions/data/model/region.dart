import 'dart:convert';

import '/data/model/model.dart';

class Region extends Entity {
  final List<TimeZone> timeZones;

  final int? siteCount;

  const Region({
    this.timeZones = const [],
    this.siteCount,
    super.active,
    super.id,
    super.name,
    super.deactivationDate,
    super.deactivationUserName,
  });

  // check if the region can be deleted
  bool get deletable => (siteCount == 0 || siteCount == null) && active == true;

  List<TimeZone> get associatedTimeZones =>
      timeZones.where((timeZone) => timeZone.assigned).toList();

  // return map of region details, which will be display on side slider and details page
  @override
  Map<String, dynamic> detailItemsToMap() {
    return {
      'Region Name': name,
      'Time Zones Associated': timeZones
          .where((timeZone) => timeZone.assigned)
          .map((timeZone) => timeZone.name)
          .toList(),
    }..addEntries(super.detailItemsToMap().entries);
  }

  // return map of region details, which will be displayed on table view
  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Region Name': name,
      'Time Zones Associated': timeZones.map((e) => e.name).toList(),
      'Active': active,
    };
  }

  // set the field for equality of region
  @override
  List<Object?> get props => [
        timeZones,
        siteCount,
        ...super.props,
      ];

  // return new region with updated fields
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

  // return the map of region
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

  // return new region from map
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
      siteCount: map['siteCount'],
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  // return json of region for payload
  String toJson() => json.encode(toMap());

  // return new region from json
  factory Region.fromJson(String source) => Region.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
