import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../model/sidebar_item.dart';
import '/features/features.dart';

class SidebarRepsitory {
  static List<SidebarItemModel> mainItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.command,
      color: Colors.purple,
      label: 'Dashboard',
      path: 'dashboard',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.circlesThreePlus,
      color: Colors.pink,
      label: 'Observations',
      path: 'observations',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.scan,
      color: const Color(0xffe34343),
      label: 'Audits  ',
      path: 'audits1',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.barcode,
      color: const Color(0xff26a196),
      label: 'Action Items',
      path: 'action-items',
    ),
  ];

  static List<SidebarItemModel> administrationItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.buildings,
      color: Colors.purple,
      label: 'Sites',
      path: 'sites',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.infinity,
      color: Colors.greenAccent[700]!,
      label: 'Companies',
      path: 'companies',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.notePencil,
      color: Colors.yellow[600]!,
      label: 'Projects',
      path: 'projects',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.plusMinus,
      color: Colors.teal,
      label: 'Audits',
      subItems: <SidebarItemModel>[
        SidebarItemModel(
          iconData: PhosphorIcons.clipboardText,
          color: Colors.teal,
          label: 'Templates',
          path: 'templates',
        ),
        SidebarItemModel(
          iconData: PhosphorIcons.plusMinus,
          color: Colors.teal,
          label: 'Audits ',
          path: 'audits',
        ),
      ],
    ),
    SidebarItemModel(
        iconData: PhosphorIcons.aperture,
        color: Colors.teal,
        label: 'Masters',
        subItems: [
          SidebarItemModel(
            iconData: PhosphorIcons.globeHemisphereWest,
            color: Colors.teal,
            label: 'Regions',
            path: 'regions',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.bellRinging,
            color: Colors.redAccent,
            label: 'Priority Levels',
            path: 'priority-levels',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.circlesFour,
            color: Colors.blueAccent,
            label: 'Observation Types',
            path: 'observation-types',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.circlesThree,
            color: Colors.redAccent,
            label: 'Awareness Groups',
            path: 'awareness-groups',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.checkSquareOffset,
            color: Colors.blueAccent,
            label: 'Awareness Categories',
            path: 'awareness-categories',
          ),
        ]),
    SidebarItemModel(
      iconData: PhosphorIcons.usersThree,
      color: Colors.blueAccent,
      label: 'Users',
      path: 'users',
    ),
  ];

  static List<SidebarItemModel> profileItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.user,
      color: Colors.pink,
      label: 'My Page',
      path: 'my-page',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.power,
      color: Colors.pink,
      label: 'Logout',
      path: 'logout',
    ),
  ];

  static List<SidebarItemModel> getItems() {
    List<SidebarItemModel> items = List.from(mainItems);
    for (var item in administrationItems) {
      for (var i in item.subItems) {
        items.add(i);
      }
      if (item.subItems.isEmpty) {
        items.add(item);
      }
    }
    return items;
  }

  static String getPath(String label) {
    return [...mainItems, ...administrationItems]
        .firstWhere((element) => element.label == label)
        .path;
  }
}
