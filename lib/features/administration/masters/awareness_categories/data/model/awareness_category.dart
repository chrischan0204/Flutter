// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity implements Equatable {
  final String name;
  final String groupName;
  final bool active;
  AwarenessCategory({
    required super.id,
    required this.groupName,
    required this.name,
    required this.active,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': name,
      'Group Name': groupName,
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        name,
        active,
        groupName,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': name,
      'Group Name': groupName,
      'Active': active,
    };
  }

  AwarenessCategory copyWith({
    String? id,
    String? name,
    String? groupName,
    bool? active,
  }) {
    return AwarenessCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      groupName: groupName ?? this.groupName,
      active: active ?? this.active,
    );
  }

  @override
  Map<String, EntityInputType> inputTypesToMap() {
    // TODO: implement inputTypesToMap
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'groupName': groupName,
      'active': active,
    };
  }

  factory AwarenessCategory.fromMap(Map<String, dynamic> map) {
    return AwarenessCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      groupName: map['groupName'] as String,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AwarenessCategory.fromJson(String source) =>
      AwarenessCategory.fromMap(json.decode(source) as Map<String, dynamic>);
}
