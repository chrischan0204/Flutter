import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

// standadized model, which other models inherit
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

  // constructor to create entity from map
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      active: map['active'] != null ? map['active'] as bool : true,
      deactivationDate: map['deactivationDate'] != null
          ? map['deactivationDate'] as String
          : null,
      deactivationUserName: map['deactivationUserName'] != null
          ? map['deactivationUserName'] as String
          : null,
    );
  }

  // return the entity object as map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'active': active,
    };
  }

  // return table details map
  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{};
  }

  // return table details map
  Map<String, dynamic> sideDetailItemsToMap() {
    return tableItemsToMap();
  }

  // return side detail amp
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

// response object to get the response from api, which others wil inherit it
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
    String message = (map['message'] ?? (map['Description'] ?? '')).toString();
    message = message.replaceAll('"', '');
    return EntityResponse(
      isSuccess: map['isSuccess'] == null
          ? (map['message'] ?? (map['Message'] ?? ''))
              .toString()
              .contains('success')
          : map['isSuccess'] as bool,
      message: message,
      data: Entity.fromMap(
          map['data'] != null ? map['data'] as Map<String, dynamic> : {}),
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
