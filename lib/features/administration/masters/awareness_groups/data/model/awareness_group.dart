import 'dart:convert';

import '/data/model/model.dart';

class AwarenessGroup extends Entity {
  final int categoryCount;
  final List<AwarenessCategory> awarenessCategories;

  const AwarenessGroup({
    super.name,
    super.active,
    this.categoryCount = 0,
    super.id,
    this.awarenessCategories = const [],
  });

  // return map of awareness group details, which will be displayed on side slider and details page
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
    };
  }

  // return possibility to delete the awareness group
  bool get deletable => categoryCount == 0 && awarenessCategories.isEmpty;

  // return map of awareness category details for table view
  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
    };
  }

  // return new awareness group with updated fields
  AwarenessGroup copyWith({
    String? id,
    String? name,
    bool? active,
    int? categoryCount,
    List<AwarenessCategory>? awarenessCategories,
  }) {
    return AwarenessGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      categoryCount: categoryCount ?? this.categoryCount,
      awarenessCategories: awarenessCategories ?? this.awarenessCategories,
    );
  }

  // return map of awareness group
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'active': active,
    };
    if (id != null) {
      map.addEntries([MapEntry('id', id)]);
    }
    return map;
  }

  // return awareness group from map
  factory AwarenessGroup.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return AwarenessGroup(
      id: entity.id,
      name: entity.name,
      active: entity.active,
      categoryCount: map['categoryCount'] as int,
      awarenessCategories: List.from(map['awarenessCategories'])
          .map((awarenessCategoryMap) =>
              AwarenessCategory.fromMap(awarenessCategoryMap))
          .toList(),
    );
  }

  // return json for awareness group
  String toJson() => json.encode(toMap());

  // return new awareness group from json
  factory AwarenessGroup.fromJson(String source) =>
      AwarenessGroup.fromMap(json.decode(source) as Map<String, dynamic>);
}
