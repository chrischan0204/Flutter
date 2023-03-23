import 'package:flutter/material.dart';

class SidebarItemModel {
  final IconData iconData;
  final Color color;
  final String label;
  final List<SidebarItemModel> subItems;
  final String path;
  SidebarItemModel({
    required this.iconData,
    required this.color,
    required this.label,
    this.subItems = const <SidebarItemModel>[],
    this.path = '',
  });
}

// enum SidebarItemName {
//   dashboard,
//   obervations,
//   audits1,
//   actionItems,
//   sites,
//   companies,
//   projects,
//   audits,
//   regions,
//   priorityLevels,
//   observationTypes,
//   awarenessGroups,
//   awarenessCategories,
//   users,
//   myPage,
// }
