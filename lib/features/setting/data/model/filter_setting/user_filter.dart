// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_filter_item.dart';

class UserFilter extends Equatable {
  final String id;
  final String filterName;
  final String viewName;
  final bool isDefault;
  final bool deleted;
  final List<UserFilterItem> userFilterItems;
  const UserFilter({
    required this.id,
    required this.filterName,
    required this.viewName,
    required this.isDefault,
    required this.deleted,
    required this.userFilterItems,
  });

  @override
  List<Object?> get props => [
        id,
        filterName,
        viewName,
        isDefault,
        deleted,
        userFilterItems,
      ];

  UserFilter copyWith({
    String? id,
    String? filterName,
    String? viewName,
    bool? isDefault,
    bool? deleted,
    List<UserFilterItem>? userFilterItems,
  }) {
    return UserFilter(
      id: id ?? this.id,
      filterName: filterName ?? this.filterName,
      viewName: viewName ?? this.viewName,
      isDefault: isDefault ?? this.isDefault,
      deleted: deleted ?? this.deleted,
      userFilterItems: userFilterItems ?? this.userFilterItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'filterName': filterName,
      'viewName': viewName,
      'isDefault': isDefault,
      'deleted': deleted,
      'userFilterItems': userFilterItems
          .map((userFilterItem) => userFilterItem.toMap())
          .toList(),
    };
  }

  factory UserFilter.fromMap(Map<String, dynamic> map) {
    return UserFilter(
      id: map['id'] as String,
      filterName: map['filterName'] as String,
      viewName: map['viewName'] as String,
      isDefault: map['isDefault'] as bool,
      deleted: (map['deleted'] ?? false) as bool,
      userFilterItems: List<UserFilterItem>.from(
        (map['userFilterItems']).map(
          (userFilterItemMap) => UserFilterItem.fromMap(userFilterItemMap),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFilter.fromJson(String source) =>
      UserFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
