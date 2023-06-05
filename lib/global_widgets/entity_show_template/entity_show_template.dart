import 'package:flutter/material.dart';

import '/data/model/entity.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';

class EntityShowTemplate extends StatefulWidget {
  final String title;
  final String label;
  final Map<String, Widget> tabItems;
  final Widget? customDetailWidget;
  final VoidCallback deleteEntity;
  final EntityStatus crudStatus;
  final bool deletable;
  final Entity? entity;
  final String descriptionForDelete;

  const EntityShowTemplate({
    super.key,
    required this.title,
    required this.label,
    this.tabItems = const <String, Widget>{},
    this.customDetailWidget,
    required this.deleteEntity,
    this.crudStatus = EntityStatus.initial,
    this.deletable = true,
    this.entity,
    this.descriptionForDelete = '',
  });

  @override
  State<EntityShowTemplate> createState() => _EntityShowTemplateState();
}

class _EntityShowTemplateState extends State<EntityShowTemplate> {
  late int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderView(
              title: widget.title,
              name: widget.entity?.name ?? "",
              label: widget.label,
              deleting: widget.crudStatus.isLoading,
              deletable: widget.deletable,
              descriptionForDelete: widget.descriptionForDelete,
              deleteEntity: widget.deleteEntity,
            ),
            const CustomDivider(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: widget.tabItems.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTab(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          selectedTabIndex != 0
                              ? widget.tabItems.entries
                                  .toList()[selectedTabIndex]
                                  .value
                              : _buildEntityDetails(),
                        ],
                      )
                    : _buildEntityDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomTab _buildTab() {
    return CustomTab(
      initialIndex: 0,
      onSelect: (int index) => setState(() {
        selectedTabIndex = index;
      }),
      containerBorderRadius: 6,
      containerColor: Colors.transparent,
      slidersBorder: Border.all(color: grey),
      slidersColors: const [
        Colors.white,
      ],
      containerHeight: 42,
      containerWidth: 550,
      borderColor: grey,
      children: widget.tabItems.entries
          .map(
            (tabItem) => Text(
              tabItem.key,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
                color: darkTeal,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildEntityDetails() {
    return SingleChildScrollView(
      child: widget.customDetailWidget ??
          (widget.entity != null
              ? Builder(
                  builder: (context) {
                    Map<String, dynamic> detailsMap =
                        widget.entity!.detailItemsToMap();
                    return Column(
                      children: detailsMap.entries
                          .map(
                            (detail) => ShowItem(
                              label: detail.key,
                              content: CustomDataCell(
                                data: detail.value,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: Center(
                    child: Loader(),
                  ),
                )),
    );
  }
}
