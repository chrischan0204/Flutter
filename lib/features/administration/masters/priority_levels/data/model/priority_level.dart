// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/data/model/entity.dart';

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class PriorityLevel extends Entity implements Equatable {
  final Color colorCode;
  final String priorityType;
  final bool active;
  PriorityLevel({
    super.id,
    super.name,
    required this.colorCode,
    required this.priorityType,
    required this.active,
  });
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Priority Level': name,
      'Color associated': colorCode,
      'Priority Type': priorityType,
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        colorCode,
        priorityType,
        active,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Priority Level': name,
      'Color associated': colorCode,
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
  }) {
    return PriorityLevel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
      priorityType: priorityType ?? this.priorityType,
      active: active ?? this.active,
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
    return PriorityLevel(
      id: map['id'] as String,
      name: map['name'] as String,
      colorCode: ('${map['colorCode']}').toColor(),
      priorityType: map['priorityType'] as String,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PriorityLevel.fromJson(String source) =>
      PriorityLevel.fromMap(json.decode(source) as Map<String, dynamic>);
}
