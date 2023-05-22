import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:safety_eta/common_libraries.dart';

import 'user_filter_item.dart';

class UserFilter extends Equatable {
  final String id;
  final String filterName;
  final String viewName;
  final bool isDefault;
  final bool deleted;
  final List<UserFilterItem> userFilterItems;
  const UserFilter({
    this.id = '00000000-0000-0000-0000-000000000000',
    this.filterName = '',
    required this.viewName,
    this.isDefault = false,
    this.deleted = false,
    this.userFilterItems = const [],
  });

  @override
  List<Object?> get props => [
        id,
        filterName,
        viewName,
        isDefault,
        deleted,
        userFilterItems,
        undeletedUserFilterItems,
      ];

  List<UserFilterItem> get undeletedUserFilterItems =>
      userFilterItems.where((element) => !element.deleted).toList();

  UserFilterSetting get userFilterSetting => UserFilterSetting(
        id: id,
        filterName: filterName,
        isDefault: isDefault,
      );

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
      'filterItems': userFilterItems
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
        (map['filterItems']).map(
          (userFilterItemMap) => UserFilterItem.fromMap(userFilterItemMap),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFilter.fromJson(String source) =>
      UserFilter.fromMap(json.decode(source) as Map<String, dynamic>);
}
