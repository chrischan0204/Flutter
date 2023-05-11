import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserFilterItemUpdate extends Equatable {
  final String id;
  final String viewSettingId;
  final String booleanCondition;
  final String operator;
  final String filterValue;
  final bool deleted;
  const UserFilterItemUpdate({
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

  UserFilterItemUpdate copyWith({
    String? id,
    String? viewSettingId,
    String? booleanCondition,
    String? operator,
    String? filterValue,
    bool? deleted,
  }) {
    return UserFilterItemUpdate(
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

  String toJson() => json.encode(toMap());
}
