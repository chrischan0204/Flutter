import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_filter_item.dart';

class UserFilter extends Equatable {
  final String id;
  final String filterName;
  final String viewName;
  final String isDefault;
  final List<UserFilterItem> filterItems;
  const UserFilter({
    required this.id,
    required this.filterName,
    required this.viewName,
    required this.isDefault,
    required this.filterItems,
  });

  @override
  List<Object?> get props => [
        id,
        filterName,
        viewName,
        isDefault,
        filterItems,
      ];

  UserFilter copyWith({
    String? id,
    String? filterName,
    String? viewName,
    String? isDefault,
    List<UserFilterItem>? filterItems,
  }) {
    return UserFilter(
      id: id ?? this.id,
      filterName: filterName ?? this.filterName,
      viewName: viewName ?? this.viewName,
      isDefault: isDefault ?? this.isDefault,
      filterItems: filterItems ?? this.filterItems,
    );
  }

  factory UserFilter.fromMap(Map<String, dynamic> map) {
    return UserFilter(
      id: map['id'] as String,
      filterName: map['filterName'] as String,
      viewName: map['viewName'] as String,
      isDefault: map['isDefault'] as String,
      filterItems: List<UserFilterItem>.from(
        (map['filterItems'] as List<int>).map<UserFilterItem>(
          (x) => UserFilterItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory UserFilter.fromJson(String source) =>
      UserFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
