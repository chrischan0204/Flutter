import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/utils/custom_alert.dart';
import 'package:strings/strings.dart';

import '/data/model/entity.dart';
import '/constants/color.dart';
import '/global_widgets/global_widget.dart';

class EntityShowTemplate extends StatefulWidget {
  final String title;
  final String label;
  final Map<String, Widget> tabItems;
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
            _buildHeader(context),
            const CustomDivider(),
            Padding(
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
    return widget.entity != null
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
              child: CircularProgressIndicator(),
            ),
          );
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.title} - ${widget.entity?.name ?? ""}',
            style: TextStyle(
              color: darkTeal,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          _buildCrudButtons(context)
        ],
      ),
    );
  }

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGoToListButton(context),
        const SizedBox(
          width: 15,
        ),
        _buildGoToEditButton(context),
        const SizedBox(
          width: 15,
        ),
        _buildDeleteButton(context),
      ],
    );
  }

  CustomButton _buildDeleteButton(BuildContext context) {
    return widget.crudStatus == EntityStatus.loading
        ? CustomButton(
            backgroundColor: const Color(0xffef4444),
            hoverBackgroundColor: const Color(0xffd73d3d),
            disabled: true,
            body: LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 22,
            ),
          )
        : CustomButton(
            backgroundColor: const Color(0xffef4444),
            hoverBackgroundColor: const Color(0xffd73d3d),
            iconData: PhosphorIcons.gear,
            text: 'Delete ${camelize(widget.label)}',
            onClick: () {
              if (widget.deletable) {
                CustomAlert(
                  context: context,
                  title: 'Confirm',
                  width: MediaQuery.of(context).size.width / 4,
                  description:
                      'Do you really want to delete this ${widget.label}?',
                  btnOkText: 'Delete',
                  btnOkOnPress: () => widget.deleteEntity(),
                  btnCancelOnPress: () {},
                  dialogType: DialogType.question,
                ).show();
              } else {
                CustomAlert(
                  context: context,
                  width: MediaQuery.of(context).size.width / 4.5,
                  description: widget.descriptionForDelete,
                  btnOkText: 'OK',
                  btnOkOnPress: () {},
                  dialogType: DialogType.warning,
                ).show();
              }
            },
          );
  }

  CustomButton _buildGoToEditButton(BuildContext context) {
    return CustomButton(
      backgroundColor: warnColor,
      hoverBackgroundColor: warnHoverColor,
      iconData: PhosphorIcons.gear,
      text: 'Edit ${camelize(widget.label)}',
      onClick: () => GoRouter.of(context).go(
        GoRouter.of(context).location.replaceAll('show', 'edit'),
      ),
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primarHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: '${camelize(widget.label)} List',
      onClick: () {
        String location = GoRouter.of(context).location;
        location = location.replaceRange(location.indexOf('show'), null, '');
        GoRouter.of(context).go(location);
      },
    );
  }
}
