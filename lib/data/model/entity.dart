import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:safety_eta/utils/utils.dart';

// standadized model, which other models inherit
class Entity extends Equatable {
  final String? id;
  final String? name;
  final String? deactivationDate;
  final String? deactivationUserName;
  final bool active;
  final String? createdOn;
  final String? createdByUserName;
  final String? lastModifiedByUserName;
  final String? lastModifiedOn;

  const Entity({
    this.id,
    this.name,
    this.deactivationDate,
    this.deactivationUserName,
    this.active = true,
    this.createdByUserName,
    this.createdOn,
    this.lastModifiedByUserName,
    this.lastModifiedOn,
  });

  // constructor to create entity from map
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      active: map['active'] != null ? map['active'] as bool : true,
      deactivationDate: map['deactivationDate'] != null
          ? FormatDate(format: 'd MMMM y', dateString: map['deactivationDate'])
              .formatDate
          : '',
      deactivationUserName: map['deactivationUserName'] != null
          ? map['deactivationUserName'] as String
          : '',
      createdByUserName: map['createdByUserName'] ?? '',
      createdOn: map['createdOn'] != null
          ? FormatDate(format: 'd MMMM y', dateString: map['createdOn'] ?? '')
              .formatDate
          : '',
      lastModifiedOn: map['lastModifiedOn'] != null
          ? FormatDate(
                  format: 'd MMMM y', dateString: map['lastModifiedOn'] ?? '')
              .formatDate
          : '--',
      lastModifiedByUserName:
          map['lastModifiedByUserName'] ?? map['updatedByUserName'] ?? '--',
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

  // return side detail map
  Map<String, dynamic> detailItemsToMap() {
    if (!active &&
        deactivationDate != null &&
        deactivationUserName != null &&
        deactivationDate!.isNotEmpty &&
        deactivationUserName!.isNotEmpty) {
      return <String, dynamic>{
        'Active': active,
        'Deactivated': 'By: $deactivationUserName on $deactivationDate',
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
        createdOn,
        createdByUserName,
      ];
}

// response object to get the response from api, which others wil inherit it
class EntityResponse {
  final bool isSuccess;
  String message;
  final int statusCode;
  final Entity? data;
  EntityResponse({
    required this.isSuccess,
    required this.message,
    this.statusCode = 200,
    this.data,
  }) {
    message = message.replaceAll('"', '');
  }

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
      statusCode: map['StatusCode'] ?? 200,
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

  EntityResponse copyWith({
    bool? isSuccess,
    String? message,
    Entity? data,
    int? statusCode,
  }) {
    return EntityResponse(
      statusCode: statusCode ?? this.statusCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}

enum EntityStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == EntityStatus.loading;
  bool get isSuccess => this == EntityStatus.success;
  bool get isFailure => this == EntityStatus.failure;
}

extension BoolToEntityStatus on bool {
  EntityStatus toEntityStatusCode() {
    return this ? EntityStatus.success : EntityStatus.failure;
  }
}
