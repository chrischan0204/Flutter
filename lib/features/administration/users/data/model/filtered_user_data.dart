import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/common_libraries.dart';

class FilteredUserData extends Equatable {
  final List<EntityHeader> headers;
  final List<FilteredUser> data;
  const FilteredUserData({
    required this.headers,
    required this.data,
  });

  @override
  List<Object?> get props => [
        headers,
        data,
      ];

  factory FilteredUserData.fromMap(Map<String, dynamic> map) {
    return FilteredUserData(
      headers: List<EntityHeader>.from(
        (map['headers']).map<EntityHeader>(
          (x) => EntityHeader.fromMap(x),
        ),
      ),
      data: List<FilteredUser>.from(
        (map['data']).map<FilteredUser>(
          (x) => FilteredUser.fromMap(x),
        ),
      ),
    );
  }

  factory FilteredUserData.fromJson(String source) =>
      FilteredUserData.fromMap(json.decode(source) as Map<String, dynamic>);
}
