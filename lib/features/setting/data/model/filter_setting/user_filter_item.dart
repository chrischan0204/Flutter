// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserFilterItem extends Equatable {
  final String id;
  final String viewSettingId;
  final String booleanCondition;
  final String operator;
  final String filterValue;
  final bool deleted;
  const UserFilterItem({
    required this.id,
    required this.viewSettingId,
    required this.booleanCondition,
    required this.operator,
    required this.filterValue,
    required this.deleted,
  });

  @override
  List<Object?> get props => [
        id,
        viewSettingId,
        booleanCondition,
        operator,
        filterValue,
        deleted,
      ];

  UserFilterItem copyWith({
    String? id,
    String? viewSettingId,
    String? booleanCondition,
    String? operator,
    String? filterValue,
    bool? deleted,
  }) {
    return UserFilterItem(
      id: id ?? this.id,
      viewSettingId: viewSettingId ?? this.viewSettingId,
      booleanCondition: booleanCondition ?? this.booleanCondition,
      operator: operator ?? this.operator,
      filterValue: filterValue ?? this.filterValue,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewSettingId': viewSettingId,
      'booleanCondition': booleanCondition,
      'operator': operator,
      'filterValue': filterValue,
      'deleted': deleted,
    };
  }

  factory UserFilterItem.fromMap(Map<String, dynamic> map) {
    return UserFilterItem(
      id: map['id'] as String,
      viewSettingId: map['viewSettingId'] as String,
      booleanCondition: map['booleanCondition'] as String,
      operator: map['operator'] as String,
      filterValue: map['filterValue'] as String,
      deleted: (map['deleted'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFilterItem.fromJson(String source) =>
      UserFilterItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
