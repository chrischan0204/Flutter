// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '/data/model/model.dart';

class Company extends Entity {
  final String einNumber;
  const Company({
    super.id,
    super.name,
    required this.einNumber,
    super.active,
    super.deactivationDate,
    super.deactivationUserName,
  });

  Company copyWith({
    String? id,
    String? name,
    String? einNumber,
    bool? active,
    String? deactivationDate,
    String? deactivationUserName,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      einNumber: einNumber ?? this.einNumber,
      active: active ?? this.active,
      deactivationDate: deactivationDate ?? deactivationDate,
      deactivationUserName: deactivationUserName ?? deactivationUserName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'einNumber': einNumber,
      'active': active,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    Entity entity = Entity.fromMap(map);
    return Company(
      id: entity.id,
      name: entity.name,
      einNumber: map['einNumber'] as String,
      active: entity.active,
      deactivationDate: entity.deactivationDate,
      deactivationUserName: entity.deactivationUserName,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);
}
