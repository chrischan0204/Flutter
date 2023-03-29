// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity implements Equatable {
  final String groupId;
  final String groupName;
  const AwarenessCategory({
    required this.groupId,
    required this.groupName,
    super.id,
    super.name,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': name,
      'Group Name': groupName,
      'Active': active,
    }..addEntries(super.detailItemsToMap().entries);
  }

  @override
  List<Object?> get props => [
        groupName,
        ...super.props,
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
    Entity entity = Entity.fromMap(map);
    return AwarenessCategory(
      id: entity.id,
      name: entity.name,
      groupId: map['groupId'] as String,
      groupName: map['groupName'] as String,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
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
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return AwarenessCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      groupId: groupId ?? this.groupId,
      groupName: groupName ?? this.groupName,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? this.deactivationDate,
      deactivationUserName: deactivationUserName ?? this.deactivationUserName,
    );
  }
}
