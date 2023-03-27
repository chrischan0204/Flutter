// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/data/model/entity.dart';

class TimeZone extends Entity implements Equatable {
  final String? abbreviation;
  final bool assigned;
  TimeZone({
    super.id,
    super.name,
    this.abbreviation,
    required this.assigned,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        abbreviation,
        assigned,
      ];
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'assigned': assigned,
    };
  }

  factory TimeZone.fromMap(Map<String, dynamic> map) {
    return TimeZone(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      abbreviation:
          map['abbreviation'] != null ? map['abbreviation'] as String : null,
      assigned: map['assigned'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeZone.fromJson(String source) => TimeZone.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool? get stringify => throw UnimplementedError();

  TimeZone copyWith({
    String? id,
    String? name,
    String? abbreviation,
    bool? assigned,
  }) {
    return TimeZone(
      id: id ?? this.id,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      assigned: assigned ?? this.assigned,
    );
  }
}
