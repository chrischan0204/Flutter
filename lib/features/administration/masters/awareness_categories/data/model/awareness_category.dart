import 'dart:convert';

import '/data/model/entity.dart';

class AwarenessCategory extends Entity {
  final String groupId;
  final String groupName;
  const AwarenessCategory({
    this.groupId = '',
    this.groupName = '',
    super.id,
    super.name,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  // return map of awareness category details, which will be details for side slider and details page
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': name,
      'Group Name': groupName,
      'Active': active,
    }..addEntries(super.detailItemsToMap().entries);
  }

  // set fields for equality of awareness category
  @override
  List<Object?> get props => [
        groupName,
        ...super.props,
      ];

  // return map of awareness category table details, every key will be table header column
  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Category': name,
      'Group Name': groupName,
      'Active': active,
    };
  }

  // return map of awarness category, which will be used to serialize the json
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'name': name,
      'groupName': groupName,
      'groupId': groupId,
      'active': active,
    };
    if (id != null) {
      map.addEntries([MapEntry<String, dynamic>('id', id!)]);
    }
    return map;
  }

  // return new awareness category object from map
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

  // return json of awareness category obeject
  String toJson() => json.encode(toMap());

  // return awareness category object from json
  factory AwarenessCategory.fromJson(String source) =>
      AwarenessCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  // return new awareness category with updated fields
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
