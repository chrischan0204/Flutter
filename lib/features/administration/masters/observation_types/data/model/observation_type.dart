// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class ObservationType extends Entity implements Equatable {
  final String severity;
  final String visibility;
  const ObservationType({
    super.id,
    super.name,
    required this.severity,
    required this.visibility,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Observation Type': name,
      'Severity': severity,
      'Visibility': visibility,
    }..addEntries(super.detailItemsToMap().entries);
  }

  @override
  List<Object?> get props => [
        severity,
        visibility,
        ...super.props,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Observation Type': name,
      'Severity': severity,
      'Visibility': visibility,
      'Active': active,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    if (id == null) {
      return <String, dynamic>{
        'name': name,
        'severity': severity,
        'visibility': visibility,
        'active': active,
      };
    } else {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'severity': severity,
        'visibility': visibility,
        'active': active,
      };
    }
  }

  @override
  factory ObservationType.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return ObservationType(
      id: entity.id,
      name: entity.name,
      severity: map['severity'] as String,
      visibility: map['visibility'] as String,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory ObservationType.fromJson(String source) =>
      ObservationType.fromMap(json.decode(source) as Map<String, dynamic>);

  ObservationType copyWith({
    String? id,
    String? name,
    String? severity,
    String? visibility,
    bool? active,
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return ObservationType(
      id: id ?? this.id,
      name: name ?? this.name,
      severity: severity ?? this.severity,
      visibility: visibility ?? this.visibility,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
    );
  }
}
