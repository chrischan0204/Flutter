// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import '/data/model/model.dart';

class AwarenessGroup extends Entity implements Equatable {
  final int categoryCount;
  final List<AwarenessCategory> awarenessCategories;

  const AwarenessGroup({
    super.name,
    super.active,
    this.categoryCount = 0,
    super.id,
    this.awarenessCategories = const [],
  });
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
    };
  }

  @override
  List<Object?> get props => [
        name,
        active,
      ];

  bool get deletable => categoryCount == 0 && awarenessCategories.isEmpty;

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
    };
  }

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

  @override
  Map<String, dynamic> toMap() {
    if (id == null) {
      return <String, dynamic>{
        'name': name,
        'active': active,
      };
    } else {
      return <String, dynamic>{
        'id': id,
        'name': name,
        'active': active,
      };
    }
  }

  factory AwarenessGroup.fromMap(Map<String, dynamic> map) {
    return AwarenessGroup(
        id: map['id'] as String,
        name: map['name'] as String,
        active: map['active'] as bool,
        categoryCount: map['categoryCount'] as int,
        awarenessCategories: List.from(map['awarenessCategories'])
            .map((awarenessCategoryMap) =>
                AwarenessCategory.fromMap(awarenessCategoryMap))
            .toList());
  }

  String toJson() => json.encode(toMap());

  factory AwarenessGroup.fromJson(String source) =>
      AwarenessGroup.fromMap(json.decode(source) as Map<String, dynamic>);
}
