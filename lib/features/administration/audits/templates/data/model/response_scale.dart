import 'dart:convert';

import 'package:equatable/equatable.dart';

class ResponseScale extends Equatable {
  final String id;
  final String name;
  const ResponseScale({
    required this.id,
    required this.name,
  });
  @override
  List<Object?> get props => [
        id,
        name,
      ];

  ResponseScale copyWith({
    String? id,
    String? name,
  }) {
    return ResponseScale(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory ResponseScale.fromMap(Map<String, dynamic> map) {
    return ResponseScale(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  factory ResponseScale.fromJson(String source) =>
      ResponseScale.fromMap(json.decode(source) as Map<String, dynamic>);
}
