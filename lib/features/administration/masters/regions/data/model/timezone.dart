// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TimeZone extends Equatable {
  final String id;
  final String? name;
  final String? abbreviation;
  final bool assigned;
  const TimeZone({
    required this.id,
    this.name,
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
}
