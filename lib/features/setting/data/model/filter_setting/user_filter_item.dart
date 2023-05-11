import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserFilterItem extends Equatable {
  final String id;
  final String viewSettingId;
  final String booleanCondition;
  final String operator;
  final List<String> filterValue;
  const UserFilterItem({
    required this.id,
    required this.viewSettingId,
    required this.booleanCondition,
    required this.operator,
    required this.filterValue,
  });

  @override
  List<Object?> get props => [
        id,
        viewSettingId,
        booleanCondition,
        operator,
        filterValue,
      ];

  factory UserFilterItem.fromMap(Map<String, dynamic> map) {
    return UserFilterItem(
      id: map['id'] as String,
      viewSettingId: map['viewSettingId'] as String,
      booleanCondition: map['booleanCondition'] as String,
      operator: map['operator'] as String,
      filterValue: List.from(map['filterValue']),
    );
  }

  factory UserFilterItem.fromJson(String source) =>
      UserFilterItem.fromMap(json.decode(source) as Map<String, dynamic>);

  UserFilterItem copyWith({
    String? id,
    String? viewSettingId,
    String? booleanCondition,
    String? operator,
    List<String>? filterValue,
  }) {
    return UserFilterItem(
      id: id ?? this.id,
      viewSettingId: viewSettingId ?? this.viewSettingId,
      booleanCondition: booleanCondition ?? this.booleanCondition,
      operator: operator ?? this.operator,
      filterValue: filterValue ?? this.filterValue,
    );
  }
}
