import 'package:safety_eta/common_libraries.dart';

class Nullable<T> {
  final T value;
  const Nullable.value(this.value);
}

class EntityHeader extends Equatable {
  final String name;
  final String title;
  final bool isHidden;
  const EntityHeader({
    required this.name,
    required this.title,
    required this.isHidden,
  });

  @override
  List<Object?> get props => [
        name,
        title,
        isHidden,
      ];

  factory EntityHeader.fromMap(Map<String, dynamic> map) {
    return EntityHeader(
      name: map['name'] as String,
      title: map['title'] as String,
      isHidden: map['isHidden'] as bool,
    );
  }

  factory EntityHeader.fromJson(String source) =>
      EntityHeader.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FilteredEntity extends Equatable {
  final String id;
  final bool deleted;
  final String createdOn;
  final String createdBy;
  final String lastModifiedOn;
  final String lastModifiedByUserName;
  final String createdById;
  const FilteredEntity({
    this.id = '',
    this.deleted = false,
    this.createdOn = '',
    this.createdBy = '',
    this.createdById = emptyGuid,
    this.lastModifiedOn = '',
    this.lastModifiedByUserName = '',
  });

  @override
  List<Object?> get props => [
        id,
        deleted,
        createdOn,
        createdBy,
        createdById,
        lastModifiedOn,
        lastModifiedByUserName,
      ];

  // FilteredEntity.fromMap(Map<String, dynamic> map)
  //     : id = map['id'] ?? '',
  //       deleted = map['deleted'] ?? false,
  //       createdOn = map['created_On'] != null
  //           ? FormatDate(
  //                   format: 'd MMMM y', dateString: map['created_On'] ?? '')
  //               .formatDate
  //           : '--',
  //       createdBy = map['created_By'] ?? '',
  //       createdById = map['created_By'] ?? emptyGuid,
  //       lastModifiedOn = map['last_Modified_On'] != null
  //           ? FormatDate(
  //                   format: 'd MMMM y',
  //                   dateString: map['last_Modified_On'] ?? '')
  //               .formatDate
  //           : '--',
  //       lastModifiedByUserName = map['last_Modified_By'] ?? '';

  factory FilteredEntity.fromMap(Map<String, dynamic> map) {
    return FilteredEntity(
      id: map['id'] ?? '',
      deleted: map['deleted'] ?? false,
      createdOn: map['created_On'] != null
          ? FormatDate(format: 'd MMMM y', dateString: map['created_On'] ?? '')
              .formatDate
          : '--',
      createdBy: map['created_By'] ?? '',
      createdById: map['created_By'] ?? emptyGuid,
      lastModifiedOn: map['last_Modified_On'] != null
          ? FormatDate(
                  format: 'd MMMM y', dateString: map['last_Modified_On'] ?? '')
              .formatDate
          : '--',
      lastModifiedByUserName: map['last_Modified_By'] ?? '',
    );
  }

  factory FilteredEntity.fromJson(String source) =>
      FilteredEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

// EntityHeader.fromMap(Map<String, dynamic> map)
//       : isHidden = map['isHidden'],
//         name = map['name'],
//         title = map['title'];

// class FilteredEntityData extends Equatable {
//   final List<EntityHeader> headers;
//   final List<FilteredEntity> data;
//   final int totalRows;
//   const FilteredEntityData({
//     required this.headers,
//     required this.data,
//     required this.totalRows,
//   });

//   @override
//   List<Object?> get props => [
//         headers,
//         data,
//       ];

//   factory FilteredEntityData.fromMap(Map<String, dynamic> map) {
//     return FilteredEntityData(
//       headers: List<EntityHeader>.from(
//         (map['headers']).map<EntityHeader>(
//           (x) => EntityHeader.fromMap(x),
//         ),
//       ),
//       totalRows: map['totalRows'] ?? 0,
//       data: List.from(
//         (map['data']).map(
//           (x) => FilteredEntity.fromMap(x),
//         ),
//       ),
//     );
//   }

//   factory FilteredEntityData.fromJson(String source) =>
//       FilteredEntityData.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// standadized model, which other models inherit
class Entity extends Equatable {
  final List<EntityHeader> headers;
  final String? id;
  final String? name;
  final String? deactivationDate;
  final String? deactivationUserName;
  final bool active;
  final String? createdOn;
  final String? createdByUserName;
  final String? lastModifiedByUserName;
  final String? lastModifiedOn;
  final List<String> columns;
  final bool deleted;

  const Entity({
    this.columns = const [],
    this.headers = const [],
    this.id,
    this.name,
    this.deactivationDate,
    this.deactivationUserName,
    this.active = true,
    this.createdByUserName,
    this.createdOn,
    this.lastModifiedByUserName,
    this.lastModifiedOn,
    this.deleted = false,
  });

  // constructor to create entity from map
  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(
      headers: map['headers'] != null
          ? List.from(map['headers'])
              .map((e) => EntityHeader.fromMap(e))
              .toList()
          : [],
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
          : '--',
      lastModifiedOn: map['lastModifiedOn'] != null
          ? FormatDate(
                  format: 'd MMMM y', dateString: map['lastModifiedOn'] ?? '')
              .formatDate
          : '--',
      lastModifiedByUserName:
          map['lastModifiedByUserName'] ?? map['updatedByUserName'] ?? '',
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
        columns,
        deleted,
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
