// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity implements Equatable {
  final String groupId;
  final String groupName;
  final bool active;
  AwarenessCategory({
    super.id,
    required this.groupId,
    required this.groupName,
    super.name,
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

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'groupName': groupName,
      'groupId': groupId,
      'active': active,
    };
    if (id != null) {
      return map..addEntries([MapEntry<String, dynamic>('id', id!)]);
    }
    return map;
  }

  factory AwarenessCategory.fromMap(Map<String, dynamic> map) {
    return AwarenessCategory(
      id: map['id'] as String,
      name: map['name'] as String,
      groupId: map['groupId'] as String,
      groupName: map['groupName'] as String,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AwarenessCategory.fromJson(String source) =>
      AwarenessCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  AwarenessCategory copyWith({
    String? id,
    String? name,
    String? groupId,
    String? groupName,
    bool? active,
  }) {
    return AwarenessCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      active: active ?? this.active,
    );
  }
}
