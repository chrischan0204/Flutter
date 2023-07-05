// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SiteType extends Equatable {
  final String id;
  final String name;

  const SiteType({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  SiteType copyWith({
    String? id,
    String? name,
  }) {
    return SiteType(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory SiteType.fromMap(Map<String, dynamic> map) {
    return SiteType(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  factory SiteType.fromJson(String source) =>
      SiteType.fromMap(json.decode(source) as Map<String, dynamic>);
}
