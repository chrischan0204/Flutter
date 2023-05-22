import 'package:flutter/material.dart';

import '/constants/constants.dart';
import 'view_setting_column.dart';
import 'view_setting_column_update.dart';

class ViewSettingItemData {
  final String id;
  final ViewSettingColumn? selectedValue;
  final String sortDirection;
  final int order;
  final bool deleted;
  final Key key;
  ViewSettingItemData({
    this.id = emptyGuid,
    this.selectedValue,
    required this.key,
    this.order = 0,
    this.deleted = false,
    this.sortDirection = 'asc',
  });

  ViewSettingColumnUpdate? toViewSettingColumnUpdate() {
    if (selectedValue != null) {
      return ViewSettingColumnUpdate(
        id: id,
        viewSettingId: selectedValue!.viewSettingId,
        order: order,
        sortDirection: sortDirection,
        deleted: deleted,
      );
    }
    return null;
  }

  ViewSettingItemData copyWith({
    String? id,
    ViewSettingColumn? selectedValue,
    String? sortDirection,
    int? order,
    bool? deleted,
    Key? key,
  }) {
    return ViewSettingItemData(
      id: id ?? this.id,
      selectedValue: selectedValue ?? this.selectedValue,
      sortDirection: sortDirection ?? this.sortDirection,
      order: order ?? this.order,
      deleted: deleted ?? this.deleted,
      key: key ?? this.key,
    );
  }
}
