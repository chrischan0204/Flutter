import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserFilterSetting extends Equatable {
  final String id;
  final String filterName;
  final bool isDefault;
  const UserFilterSetting({
    required this.id,
    required this.filterName,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [
        id,
        filterName,
        isDefault,
      ];

  UserFilterSetting copyWith({
    String? id,
    String? filterName,
    bool? isDefault,
  }) {
    return UserFilterSetting(
      id: id ?? this.id,
      filterName: filterName ?? this.filterName,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory UserFilterSetting.fromMap(Map<String, dynamic> map) {
    return UserFilterSetting(
      id: map['id'] as String,
      filterName: map['filterName'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  factory UserFilterSetting.fromJson(String source) =>
      UserFilterSetting.fromMap(json.decode(source) as Map<String, dynamic>);
}
