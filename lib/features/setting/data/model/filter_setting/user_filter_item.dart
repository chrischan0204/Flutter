import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'filter_setting.dart';

class UserFilterItem extends Equatable {
  final String id;
  final FilterSetting filterSetting;
  final String booleanCondition;
  final String operator;
  final List<String> filterValue;
  final bool deleted;
  const UserFilterItem({
    this.id = '00000000-0000-0000-0000-000000000000',
    this.filterSetting = const FilterSetting(),
    this.booleanCondition = 'And',
    this.operator = '=',
    this.filterValue = const [],
    this.deleted = false,
  });

  @override
  List<Object?> get props => [
        id,
        filterSetting,
        booleanCondition,
        operator,
        filterValue,
        deleted,
      ];

  bool get isNew => id == '00000000-0000-0000-0000-000000000000';

  UserFilterItem copyWith({
    String? id,
    FilterSetting? filterSetting,
    String? booleanCondition,
    String? operator,
    List<String>? filterValue,
    bool? deleted,
  }) {
    return UserFilterItem(
      id: id ?? this.id,
      filterSetting: filterSetting ?? this.filterSetting,
      booleanCondition: booleanCondition ?? this.booleanCondition,
      operator: operator ?? this.operator,
      filterValue: filterValue ?? this.filterValue,
      deleted: deleted ?? this.deleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewSettingId': filterSetting.id,
      'booleanCondition': booleanCondition,
      'operator': operator,
      'filterValue': filterValue,
      'deleted': deleted,
    };
  }

  factory UserFilterItem.fromMap(Map<String, dynamic> map) {
    return UserFilterItem(
      id: map['id'] as String,
      filterSetting: FilterSetting(id: map['viewSettingId'] as String),
      booleanCondition: map['booleanCondition'] as String,
      operator: map['operator'] as String,
      filterValue: List.from(map['filterValue']),
      deleted: (map['deleted'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFilterItem.fromJson(String source) =>
      UserFilterItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
