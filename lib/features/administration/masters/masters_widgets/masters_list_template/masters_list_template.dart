import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/constants/color.dart';
import 'package:strings/strings.dart';

import '../custom_data_cell.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/entity.dart';
import '../../../../theme/view/widgets/sidebar/sidebar_style.dart';
import 'widgets/detail_item.dart';
import 'widgets/widgets.dart';

class MastersListTemplate extends StatefulWidget {
  final List<Entity> entities;
  final String title;
  final String description;
  final String label;
  final String note;
  final ValueChanged<Entity> onRowClick;
  final Entity? selectedEntity;
  final String successType;
  const MastersListTemplate(
      {super.key,
      this.entities = const [],
      required this.description,
      required this.title,
      required this.label,
      required this.note,
      this.selectedEntity,
      required this.onRowClick,
      this.successType = ''});

  @override
  State<MastersListTemplate> createState() => _CrudState();
}

class _CrudState extends State<MastersListTemplate> {
  late double positionRightForFiltersSlier;
  late double positionRightForViewSettingsSlider;
  late double positionRightForDetailsSlider;
  late String selectedId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    positionRightForFiltersSlier = positionRightForViewSettingsSlider =
        positionRightForDetailsSlider = -MediaQuery.of(context).size.width / 4;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.successType == 'add'
                  ? Notify(
                      content:
                          '${camelize(widget.label)} Created Successfully!',
                      type: NotifyType.success,
                    )
                  : Container(),
              widget.successType == 'edit'
                  ? Notify(
                      content:
                          '${camelize(widget.label)} Details Updated Successfully!',
                      type: NotifyType.good,
                    )
                  : Container(),
              widget.successType == 'delete'
                  ? Notify(
                      content: 'The ${widget.label} was deleted.',
                      type: NotifyType.good,
                    )
                  : Container(),
              widget.successType == 'add-fail'
                  ? Notify(
                      content:
                          'There was an error while adding ${widget.label}. Our team has been notified. Please wait a few minutes and try again....',
                      type: NotifyType.failture,
                    )
                  : Container(),
              widget.successType == 'edit-fail'
                  ? Notify(
                      content:
                          'There was an error while editing ${widget.label}. Our team has been notified. Please wait a few minutes and try again....',
                      type: NotifyType.failture,
                    )
                  : Container(),
              widget.successType == 'delete-fail'
                  ? Notify(
                      content:
                          'There was an error while deleting ${widget.label}. Our team has been notified. Please wait a few minutes and try again....',
                      type: NotifyType.failture,
                    )
                  : Container(),
              _buildHeader(),
              const CustomDivider(),
              _buildTableHeader(),
              const CustomDivider(),
              _buildTableView()
            ],
          ),
        ),
        _buildDetailsSlider(context),
        _buildViewSettingsSlider(context),
        _buildFiltersSlider(context),
      ],
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageTitle(
            title: widget.title,
          ),
          CustomButton(
            backgroundColor: const Color(0xfff58646),
            hoverBackgroundColor: const Color(0xffdd793f),
            iconData: PhosphorIcons.plus,
            text: 'New ${camelize(widget.label)}',
            onClick: () {
              GoRouter.of(context).go('${GoRouter.of(context).location}/new');
            },
          )
        ],
      ),
    );
  }

  Container _buildTableView() {
    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Description(
            description: widget.description,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: sidebarColor,
                ),
              ),
            ),
            child: DataTableView(
              entities: widget.entities,
              onRowClick: (entity) {
                _showDetailsSlider();
                setState(() {
                  selectedId = entity.id!;
                });
                widget.onRowClick(entity);
              },
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Row(
        children: [
          // HeaderButton(
          //   iconData: PhosphorIcons.funnel,
          //   label: 'Filters',
          //   color: const Color(0xff0c83ff),
          //   onClick: () => _showFilterSlider(),
          // ),
          // const SizedBox(
          //   width: 50,
          // ),
          // HeaderButton(
          //   iconData: PhosphorIcons.slidersHorizontal,
          //   label: 'View Settings',
          //   color: const Color(0xfff58646),
          //   onClick: () => _showViewSettingsSlider(),
          // ),
          // const SizedBox(
          //   width: 50,
          // ),
          HeaderButton(
            iconData: PhosphorIcons.chartBar,
            label: 'Dashboard',
            color: const Color(0xff0c83ff),
            onClick: () => GoRouter.of(context).go(
              '/dashboard',
            ),
          ),
        ],
      ),
    );
  }

  AnimatedPositioned _buildFiltersSlider(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      right: positionRightForFiltersSlier,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 1000,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _hideFilterSlider(),
                    icon: const Icon(
                      PhosphorIcons.arrowCircleRight,
                      size: 20,
                      color: Color(0xffef4444),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedPositioned _buildViewSettingsSlider(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      right: positionRightForViewSettingsSlider,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 1000,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'View Settings',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _hideViewSettingsSlider(),
                    icon: const Icon(
                      PhosphorIcons.arrowCircleRight,
                      size: 20,
                      color: Color(0xffef4444),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedPositioned _buildDetailsSlider(BuildContext context) {
    return AnimatedPositioned(
      top: 0,
      right: positionRightForDetailsSlider,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 30,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectedEntity != null
                        ? widget.selectedEntity!.name ?? ''
                        : '',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w600,
                      color: darkTeal,
                      fontSize: 14,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _hideDetailsSlider(),
                    icon: const Icon(
                      PhosphorIcons.arrowCircleRight,
                      size: 20,
                      color: Color(0xffef4444),
                    ),
                  ),
                ],
              ),
            ),
            ...(widget.selectedEntity != null
                ? widget.selectedEntity!
                    .detailItemsToMap()
                    .entries
                    .map(
                      (detail) => DetailItem(
                        label: detail.key,
                        content: CustomDataCell(
                          data: detail.value,
                        ),
                      ),
                    )
                    .toList()
                : []),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: grey,
                    width: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 12,
              ),
              child: CustomButton(
                backgroundColor: const Color(0xff0c83ff),
                hoverBackgroundColor: const Color(0xff0b76e6),
                iconData: PhosphorIcons.arrowRight,
                text: '${camelize(widget.label)} Details',
                onClick: () {
                  String location = GoRouter.of(context).location;
                  GoRouter.of(context).go('$location/show/$selectedId');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showViewSettingsSlider() {
    setState(() {
      positionRightForViewSettingsSlider = 0;
      positionRightForFiltersSlier = positionRightForDetailsSlider =
          -MediaQuery.of(context).size.width / 4;
    });
  }

  void _hideViewSettingsSlider() {
    setState(() {
      positionRightForViewSettingsSlider =
          -MediaQuery.of(context).size.width / 4;
    });
  }

  void _showFilterSlider() {
    setState(() {
      positionRightForFiltersSlier = 0;
      positionRightForDetailsSlider = positionRightForViewSettingsSlider =
          -MediaQuery.of(context).size.width / 4;
    });
  }

  void _hideFilterSlider() {
    setState(() {
      positionRightForFiltersSlier = -MediaQuery.of(context).size.width / 4;
    });
  }

  void _showDetailsSlider() {
    setState(() {
      positionRightForDetailsSlider = 0;
      positionRightForFiltersSlier = positionRightForViewSettingsSlider =
          -MediaQuery.of(context).size.width / 4;
    });
  }

  void _hideDetailsSlider() {
    setState(() {
      positionRightForDetailsSlider = -MediaQuery.of(context).size.width / 4;
    });
  }
}

class HeaderButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Color color;
  final VoidCallback onClick;
  const HeaderButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.color,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => onClick(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: color,
                size: 20,
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 2.0,
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
