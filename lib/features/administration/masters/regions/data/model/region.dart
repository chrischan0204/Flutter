import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import '/data/model/model.dart';

class Region extends Entity implements Equatable {
  final List<TimeZone> timeZones;
  final bool active;
  final String? deactivationDate;
  final String? deactivationUserName;
  final int? siteCount;
  Region({
    super.id,
    this.timeZones = const [],
    required this.active,
    super.name,
    this.siteCount,
    this.deactivationDate,
    this.deactivationUserName,
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
      'Active': active,
    };
    if (deactivationDate != null && deactivationUserName != null) {
      return map
        ..addEntries([
          MapEntry('Deactivated',
              'By: $deactivationUserName on ${DateFormat('d MMMM y', 'en_US').format(DateTime.parse(deactivationDate!))}')
        ]);
    }

    return map;
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
      'siteCount': siteCount,
      'active': active,
    };
    if (active) {
      return map;
    }
    return map
      ..addEntries([
        MapEntry('deactivationDate', DateTime.now().toIso8601String()),
        const MapEntry('deactivationUserName', 'Super Admin'),
      ]);
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
      deactivationDate: map['deactivationDate'] != null
          ? map['deactivationDate'] as String
          : null,
      deactivationUserName: map['deactivationUserName'] != null
          ? map['deactivationUserName'] as String
          : null,
      siteCount: map['siteCount'] != null ? map['siteCount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) => Region.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
