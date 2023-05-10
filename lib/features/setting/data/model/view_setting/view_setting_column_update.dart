// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ViewSettingColumnUpdate extends Equatable {
  final String id;
  final String viewSettingId;
  final int order;
  final String sortDirection;
  final bool deleted;
  const ViewSettingColumnUpdate({
    required this.id,
    required this.viewSettingId,
    required this.order,
    required this.sortDirection,
    required this.deleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'viewSettingId': viewSettingId,
      'order': order,
      'sortDirection': sortDirection,
      'deleted': deleted,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => throw [
        id,
        viewSettingId,
        order,
        sortDirection,
        deleted,
      ];
}
