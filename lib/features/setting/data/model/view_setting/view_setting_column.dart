import 'dart:convert';

import 'package:equatable/equatable.dart';

class ViewSettingColumn extends Equatable {
  final String id;
  final String viewSettingId;
  final String name;
  final String title;
  const ViewSettingColumn({
    required this.id,
    required this.viewSettingId,
    required this.name,
    required this.title,
  });

  @override
  List<Object?> get props => [
        id,
        viewSettingId,
        name,
        title,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewSettingId': viewSettingId,
    };
  }

  factory ViewSettingColumn.fromMap(Map<String, dynamic> map) {
    return ViewSettingColumn(
      id: map['id'] as String,
      viewSettingId: map['viewSettingId'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewSettingColumn.fromJson(String source) =>
      ViewSettingColumn.fromMap(json.decode(source) as Map<String, dynamic>);
}
