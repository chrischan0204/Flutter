// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class ObservationType extends Entity implements Equatable {
  final String security;
  final String visibility;
  final bool active;
  ObservationType({
    required super.id,
    required super.name,
    required this.security,
    required this.visibility,
    required this.active,
  });

  @override
  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{
      'Observation Type': name,
      'Severity': security,
      'Visibility': visibility,
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        security,
        visibility,
        active,
      ];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{
      'Observation Type': name,
      'Severity': security,
      'Visibility': visibility,
      'Active': active,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'security': security,
      'visibility': visibility,
      'active': active,
    };
  }

  @override
  factory ObservationType.fromMap(Map<String, dynamic> map) {
    return ObservationType(
      id: map['id'] as String,
      name: map['name'] as String,
      security: map['security'] as String,
      visibility: map['visibility'] as String,
      active: map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ObservationType.fromJson(String source) =>
      ObservationType.fromMap(json.decode(source) as Map<String, dynamic>);

  ObservationType copyWith({
    String? id,
    String? name,
    String? security,
    String? visibility,
    bool? active,
  }) {
    return ObservationType(
      id: id ?? this.id,
      name: name ?? this.name,
      security: security ?? this.security,
      visibility: visibility ?? this.visibility,
      active: active ?? this.active,
    );
  }
}
