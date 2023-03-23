import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Entity {
  final String? id;

  Entity({
    required this.id,
  });

  factory Entity.fromMap(Map<String, dynamic> map) {
    return Entity(id: map['id'] as String);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{};
  }

  Map<String, dynamic> tableItemsToMap() {
    return <String, dynamic>{};
  }

  Map<String, dynamic> detailItemsToMap() {
    return <String, dynamic>{};
  }
}

class EntityResponse {
  final bool isSuccess;
  final String message;
  final Entity data;
  EntityResponse({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSuccess': isSuccess,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory EntityResponse.fromMap(Map<String, dynamic> map) {
    return EntityResponse(
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
      data: Entity.fromMap(map['data'] as Map<String, dynamic>),
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
  succuess,
  failure,
}
