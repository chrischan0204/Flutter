import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/data/model/entity.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class PriorityLevel extends Entity implements Equatable {
  final Color colorCode;
  final String priorityType;
  const PriorityLevel({
    super.id,
    super.name,
    required this.colorCode,
    required this.priorityType,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Priority Level': name,
      'Color Associated': colorCode,
      'Priority Type': priorityType,
    }..addEntries(super.detailItemsToMap().entries);
  }

  @override
  List<Object?> get props => [
        colorCode,
        priorityType,
        ...super.props,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Priority Level': name,
      'Color Associated': colorCode,
      'Priority Type': priorityType,
      'Active': active,
    };
  }

  PriorityLevel copyWith({
    String? id,
    String? name,
    Color? colorCode,
    String? priorityType,
    bool? active,
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return PriorityLevel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
      priorityType: priorityType ?? this.priorityType,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'colorCode': colorCode.value.toRadixString(16),
      'priorityType': priorityType,
      'active': active,
    };

    if (id == null) {
      return map;
    } else {
      return map..addEntries([MapEntry('id', id)]);
    }
  }

  factory PriorityLevel.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return PriorityLevel(
      id: entity.id,
      name: entity.name,
      colorCode: ('${map['colorCode']}').toColor(),
      priorityType: map['priorityType'] as String,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriorityLevel.fromJson(String source) =>
      PriorityLevel.fromMap(json.decode(source) as Map<String, dynamic>);
}
