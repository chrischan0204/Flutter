// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_filter_item_update.dart';

class UserFilterUpdate extends Equatable {
  final String id;
  final String filterName;
  final String viewName;
  final bool isDefault;
  final bool deleted;
  final List<UserFilterItemUpdate> userFilterItems;
  const UserFilterUpdate({
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'filterName': filterName,
      'viewName': viewName,
      'isDefault': isDefault,
      'deleted': deleted,
      'userFilterItems': userFilterItems.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  UserFilterUpdate copyWith({
    String? id,
    String? filterName,
    String? viewName,
    bool? isDefault,
    bool? deleted,
    List<UserFilterItemUpdate>? userFilterItems,
  }) {
    return UserFilterUpdate(
      id: id ?? this.id,
      filterName: filterName ?? this.filterName,
      viewName: viewName ?? this.viewName,
      isDefault: isDefault ?? this.isDefault,
      deleted: deleted ?? this.deleted,
      userFilterItems: userFilterItems ?? this.userFilterItems,
    );
  }
}
