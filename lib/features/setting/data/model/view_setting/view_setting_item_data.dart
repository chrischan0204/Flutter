import 'package:flutter/material.dart';

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
    this.id = '00000000-0000-0000-0000-000000000000',
    this.selectedValue,
    required this.key,
    required this.order,
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
    ViewSettingColumn? selectedValue,
    String? sortDirection,
    int? order,
    bool? deleted,
    Key? key,
  }) {
    return ViewSettingItemData(
      selectedValue: selectedValue ?? this.selectedValue,
      sortDirection: sortDirection ?? this.sortDirection,
      order: order ?? this.order,
      deleted: deleted ?? this.deleted,
      key: key ?? this.key,
    );
  }
}
