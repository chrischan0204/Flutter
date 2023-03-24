// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class AwarenessGroup extends Entity implements Equatable {
  final bool active;
  AwarenessGroup({
    super.name,
    required this.active,
    super.id,
  });
  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        name,
        active,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Awareness Group': name,
      'Active': active,
    };
  }

  AwarenessGroup copyWith({
    String? id,
    String? name,
    bool? active,
  }) {
    return AwarenessGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory AwarenessGroup.fromJson(String source) =>
      AwarenessGroup.fromMap(json.decode(source) as Map<String, dynamic>);
}
