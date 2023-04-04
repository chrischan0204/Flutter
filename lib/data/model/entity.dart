import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Entity extends Equatable {
  final String? id;
  final String? name;
  final String? deactivationDate;
  final String? deactivationUserName;
  final bool active;

  const Entity({
    this.id,
    this.name,
    this.deactivationDate,
    this.deactivationUserName,
    this.active = true,
  });

  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      active: map['active'] as bool,
      deactivationDate: map['deactivationDate'] != null
          ? map['deactivationDate'] as String
          : null,
      deactivationUserName: map['deactivationUserName'] != null
          ? map['deactivationUserName'] as String
          : null,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'active': active,
    };
  }

  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{};
  }

  Map<String, dynamic> detailItemsToMap() {
    if (!active && deactivationDate != null && deactivationUserName != null) {
      return <String, dynamic>{
        'Active': active,
        'Deactivated':
            'By: $deactivationUserName on ${DateFormat('d MMMM y', 'en_US').format(DateTime.parse(deactivationDate!))}',
      };
    }
    return {
      'Active': active,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        deactivationDate,
        deactivationUserName,
        active,
      ];
}

class EntityResponse {
  final bool isSuccess;
  final String message;
  final Entity? data;
  EntityResponse({
    required this.isSuccess,
    required this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory EntityResponse.fromMap(Map<String, dynamic> map) {
    return EntityResponse(
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
      // data: Entity.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory EntityResponse.fromJson(String source) =>
      EntityResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum EntityInputType {
  textField,
  singleSelect,
  multiSelect,
  colorPicker,
}

enum EntityStatus {
  initial,
  loading,
  success,
  failure,
}
