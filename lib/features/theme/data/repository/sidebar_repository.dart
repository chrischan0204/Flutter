import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../model/sidebar_item.dart';

class SidebarRepsitory {
  
  static List<SidebarItemModel> mainItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.regular.command,
      color: Colors.purple,
      label: 'Dashboard',
      path: 'dashboard',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.circlesThreePlus,
      color: Colors.pink,
      label: 'Observations',
      path: 'observations',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.scan,
      color: const Color(0xffe34343),
      label: 'Audits  ',
      path: 'audits1',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.barcode,
      color: const Color(0xff26a196),
      label: 'Action Items',
      path: 'action-items',
    ),
  ];

  static List<SidebarItemModel> administrationItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.regular.buildings,
      color: Colors.purple,
      label: 'Sites',
      path: 'sites',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.infinity,
      color: Colors.greenAccent[700]!,
      label: 'Companies',
      path: 'companies',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.notePencil,
      color: Colors.yellow[600]!,
      label: 'Projects',
      path: 'projects',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.plusMinus,
      color: Colors.teal,
      label: 'Audits',
      subItems: <SidebarItemModel>[
        SidebarItemModel(
          iconData: PhosphorIcons.regular.clipboardText,
          color: Colors.teal,
          label: 'Templates',
          path: 'templates',
        ),
        SidebarItemModel(
          iconData: PhosphorIcons.regular.plusMinus,
          color: Colors.teal,
          label: 'Audits ',
          path: 'audits',
        ),
      ],
    ),
    SidebarItemModel(
        iconData: PhosphorIcons.regular.aperture,
        color: Colors.teal,
        label: 'Masters',
        subItems: [
          SidebarItemModel(
            iconData: PhosphorIcons.regular.globeHemisphereWest,
            color: Colors.teal,
            label: 'Regions',
            path: 'regions',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.regular.bellRinging,
            color: Colors.redAccent,
            label: 'Priority Levels',
            path: 'priority-levels',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.regular.circlesFour,
            color: Colors.blueAccent,
            label: 'Observation Types',
            path: 'observation-types',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.regular.circlesThree,
            color: Colors.redAccent,
            label: 'Awareness Groups',
            path: 'awareness-groups',
          ),
          SidebarItemModel(
            iconData: PhosphorIcons.regular.checkSquareOffset,
            color: Colors.blueAccent,
            label: 'Awareness Categories',
            path: 'awareness-categories',
          ),
        ]),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.usersThree,
      color: Colors.blueAccent,
      label: 'Users',
      path: 'users',
    ),
  ];

  static List<SidebarItemModel> profileItems = <SidebarItemModel>[
    SidebarItemModel(
      iconData: PhosphorIcons.regular.user,
      color: Colors.pink,
      label: 'My Page',
      path: 'my-page',
    ),
    SidebarItemModel(
      iconData: PhosphorIcons.regular.power,
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
