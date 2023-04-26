import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:strings/strings.dart';

import '/global_widgets/global_widget.dart';
import '/data/model/entity.dart';
import '/constants/color.dart';

class EntityListTemplate extends StatefulWidget {
  final List<Entity> entities;
  final Widget? filterBody;
  final Widget? filterResultBody;
  final bool filterApplied;
  final VoidCallback? applyFilter;
  final VoidCallback? clearFilter;
  final Widget? viewSettingBody;
  final EntityStatus entityRetrievedStatus;
  final String title;
  final String description;
  final String label;
  final ValueChanged<Entity> onRowClick;
  final ValueChanged<bool>? includeDeletedChanged;
  final Entity? selectedEntity;
  final bool showTableHeaderButtons;
  final String emptyMessage;
  final ValueChanged<List<Entity>>? onTableSort;
  final IconData? newIconData;
  const EntityListTemplate({
    super.key,
    required this.title,
    this.filterBody,
    this.filterResultBody,
    this.filterApplied = false,
    this.applyFilter,
    this.clearFilter,
    this.viewSettingBody,
    required this.label,
    required this.onRowClick,
    this.includeDeletedChanged,
    this.entityRetrievedStatus = EntityStatus.initial,
    this.entities = const [],
    this.selectedEntity,
    this.description = '',
    this.emptyMessage = '',
    this.showTableHeaderButtons = false,
    this.onTableSort,
    this.newIconData,
  });

  @override
  State<EntityListTemplate> createState() => _CrudState();
}

class _CrudState extends State<EntityListTemplate> {
  late double positionRightForFiltersSlier;
  late double positionRightForViewSettingsSlider;
  late double positionRightForDetailsSlider;
  late String selectedId;
  bool includeDeleted = false;

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
              _buildHeader(),
              widget.filterApplied ? const CustomDivider() : Container(),
              widget.filterApplied
                  ? _buildFilterAppliedNotification()
                  : Container(),
              widget.filterApplied ? const CustomDivider() : Container(),
              widget.filterApplied
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: widget.filterResultBody ?? Container(),
                    )
                  : Container(),
              widget.showTableHeaderButtons ? _buildTableHeader() : Container(),
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

  Padding _buildFilterAppliedNotification() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Filter Applied',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomButton(
            backgroundColor: const Color(0xff049aad),
            hoverBackgroundColor: const Color(0xff048b9c),
            iconData: PhosphorIcons.arrowArcLeft,
            text: 'Clear Filters',
            onClick: () => widget.clearFilter!(),
          )
        ],
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      children: [
        Padding(
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
                backgroundColor: warnColor,
                hoverBackgroundColor: warnHoverColor,
                iconData: widget.newIconData ?? PhosphorIcons.plus,
                text: 'New ${camelize(widget.label)}',
                onClick: () {
                  String location = GoRouter.of(context).location;
                  int index = location.indexOf('/index');
                  if (index != -1) {
                    location = location.replaceRange(index, null, '');
                  }
                  GoRouter.of(context).go('$location/new');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildTableView() {
    return Column(
      children: [
        widget.description.isNotEmpty
            ? const CustomDivider()
            : const SizedBox(
                height: 12,
              ),
        Container(
          width: double.infinity,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.description.isNotEmpty
                  ? Description(
                      description: widget.description,
                    )
                  : Container(),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Color(0xff9ca3af),
                    ),
                  ),
                ),
                child: widget.entityRetrievedStatus == EntityStatus.loading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 200.0),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : DataTableView(
                        entities: widget.entities,
                        emptyMessage: widget.emptyMessage,
                        onTableSort: widget.onTableSort == null
                            ? null
                            : (MapEntry<String, bool> sortInfo) {
                                List<Entity> entities =
                                    List.from(widget.entities);

                                entities.sort(
                                  (a, b) {
                                    return (sortInfo.value ? 1 : -1) *
                                        (a
                                                .tableItemsToMap()[sortInfo.key]
                                                .toString()
                                                .toLowerCase())
                                            .compareTo(b
                                                .tableItemsToMap()[sortInfo.key]
                                                .toString()
                                                .toLowerCase());
                                  },
                                );
                                widget.onTableSort!(entities);
                              },
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
        ),
      ],
    );
  }

  Column _buildTableHeader() {
    return Column(
      children: [
        const CustomDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HeaderButton(
                    iconData: PhosphorIcons.funnel,
                    label: 'Filters',
                    color: const Color(0xff0c83ff),
                    onClick: () => _showFilterSlider(),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  HeaderButton(
                    iconData: PhosphorIcons.slidersHorizontal,
                    label: 'View Settings',
                    color: warnColor,
                    onClick: () => _showViewSettingsSlider(),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  HeaderButton(
                    iconData: PhosphorIcons.chartBar,
                    label: 'Dashboard',
                    color: const Color(0xff0c83ff),
                    onClick: () => GoRouter.of(context).go(
                      '${GoRouter.of(context).location}/dashboard',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: includeDeleted,
                    onChanged: (value) {
                      if (widget.includeDeletedChanged != null) {
                        widget.includeDeletedChanged!(value!);
                      }

                      setState(() {
                        includeDeleted = !includeDeleted;
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  const SizedBox(width: 3),
                  const Text(
                    'Include Deleted',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
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
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height - 75),
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
                  ),
                ],
              ),
            ),
            widget.filterBody ?? Container(),
            Divider(
              color: grey,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: CustomButton(
                backgroundColor: const Color(0xff0c83ff),
                hoverBackgroundColor: const Color(0xff0b76e6),
                iconData: PhosphorIcons.arrowRight,
                text: 'Apply Filters',
                onClick: () {
                  widget.applyFilter!();
                  _hideFilterSlider();
                },
              ),
            )
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
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height - 75),
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
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height - 75),
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
                    .sideDetailItemsToMap()
                    .entries
                    .map(
                      (detail) => DetailItem(
                        label: detail.key,
                        isTwoLine: detail.value is Map,
                        content: CustomDataCell(
                          data: detail.value is Map
                              ? detail.value['content']
                              : detail.value,
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
                  int index = location.indexOf('/index');
                  if (index != -1) {
                    location = location.replaceRange(index, null, '');
                  }

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
