import 'package:flutter/gestures.dart';

import '/common_libraries.dart';
import 'package:strings/strings.dart';

class EntityListTemplate extends StatefulWidget {
  final List<Entity> entities;
  final VoidCallback? onViewSettingApplied;
  final VoidCallback? onViewSettingSliderOpened;
  final ValueChanged<String>? onFilterSaved;
  final void Function([String?])? onFilterApplied;
  final EntityStatus entityRetrievedStatus;
  final String title;
  final String description;
  final String label;
  final ValueChanged<Entity> onRowClick;
  final ValueChanged<bool>? onIncludeDeletedChanged;
  final Entity? selectedEntity;
  final bool showTableHeaderButtons;
  final String emptyMessage;
  final ValueChanged<List<Entity>>? onTableSorted;
  final IconData? newIconData;
  final List<String> columns;
  final String? viewName;
  const EntityListTemplate({
    super.key,
    required this.title,
    this.onViewSettingApplied,
    this.onViewSettingSliderOpened,
    this.onFilterSaved,
    this.onFilterApplied,
    required this.label,
    required this.onRowClick,
    this.onIncludeDeletedChanged,
    this.entityRetrievedStatus = EntityStatus.initial,
    this.entities = const [],
    this.selectedEntity,
    this.description = '',
    this.emptyMessage = '',
    this.showTableHeaderButtons = false,
    this.onTableSorted,
    this.newIconData,
    this.columns = const [],
    this.viewName,
  });

  @override
  State<EntityListTemplate> createState() => _CrudState();
}

class _CrudState extends State<EntityListTemplate> {
  late double positionRightForViewSettingsSlider;
  late double positionRightForDetailsSlider;
  late String selectedId;
  bool includeDeleted = false;
  bool filterViewShow = false;

  late FilterSettingBloc filterSettingBloc;

  String token = '';

  @override
  void initState() {
    filterSettingBloc = context.read();
    if (widget.viewName != null) {
      filterSettingBloc.add(FilterSettingInit(viewName: widget.viewName!));
      // filterSettingBloc
      //     .add(FilterSettingFilterSettingListLoaded(name: widget.viewName!));
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    positionRightForViewSettingsSlider =
        positionRightForDetailsSlider = -MediaQuery.of(context).size.width / 4;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return Container(
          constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height - topbarHeight - 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    widget.showTableHeaderButtons
                        ? _buildTableHeader()
                        : Container(),
                    filterViewShow && widget.viewName != null
                        ? FilterSettingView(
                            viewName: widget.viewName!,
                            onFilterOptionClosed: () => _hideFilterView(),
                            onFilterApplied: (filterId) {
                              if (widget.onFilterApplied != null) {
                                widget.onFilterApplied!(filterId);
                              }
                            },
                            onFilterSaved: (filterId) =>
                                widget.onFilterSaved!(filterId),
                          )
                        : Container(),
                    _buildTableView()
                  ],
                ),
              ),
              _buildDetailsSlider(context),
              _buildViewSettingsSlider(context),
            ],
          ),
        );
      },
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

  Expanded _buildTableView() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: SingleChildScrollView(
          child: Column(
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
                      child:
                          widget.entityRetrievedStatus == EntityStatus.loading
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 200.0),
                                  child: Center(
                                    child: Loader(),
                                  ),
                                )
                              : DataTableView(
                                  entities: widget.entities,
                                  columns: widget.columns,
                                  emptyMessage: widget.emptyMessage,
                                  onTableSorted: widget.onTableSorted == null
                                      ? null
                                      : (MapEntry<String, bool> sortInfo) {
                                          List<Entity> entities =
                                              List.from(widget.entities);

                                          entities.sort(
                                            (a, b) {
                                              return (sortInfo.value ? 1 : -1) *
                                                  (a
                                                          .tableItemsToMap()[
                                                              sortInfo.key]
                                                          .toString()
                                                          .toLowerCase())
                                                      .compareTo(b
                                                          .tableItemsToMap()[
                                                              sortInfo.key]
                                                          .toString()
                                                          .toLowerCase());
                                            },
                                          );
                                          widget.onTableSorted!(entities);
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
          ),
        ),
      ),
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
                    onClick: () {
                      _showFilterView();
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  HeaderButton(
                    iconData: PhosphorIcons.slidersHorizontal,
                    label: 'View Settings',
                    color: warnColor,
                    onClick: () {
                      if (widget.onViewSettingSliderOpened != null) {
                        widget.onViewSettingSliderOpened!();
                      }
                      _showViewSettingsSlider();
                    },
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
                  BlocConsumer<FilterSettingBloc, FilterSettingState>(
                    listener: (context, state) {
                      if (state.selectedUserFilterSetting != null) {
                        if (widget.onFilterApplied != null) {
                          widget.onFilterApplied!(
                              state.selectedUserFilterSetting!.id);
                        }
                      }
                    },
                    listenWhen: (previous, current) =>
                        previous.selectedUserFilterSetting !=
                        current.selectedUserFilterSetting,
                    builder: (context, state) {
                      return Text(
                        'Filter Name: ${state.selectedUserFilterSetting?.filterName ?? 'No Filter'}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 3),
                  Checkbox(
                    value: includeDeleted,
                    onChanged: (value) {
                      if (widget.onIncludeDeletedChanged != null) {
                        filterSettingBloc.add(
                            FilterSettingIncludeDeletedChanged(
                                includeDeleted: value!));
                        widget.onIncludeDeletedChanged!(value);
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
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    onPressed: () {
                      if (widget.onIncludeDeletedChanged != null) {
                        widget.onIncludeDeletedChanged!(includeDeleted);
                      }
                    },
                    icon: const Icon(
                      PhosphorIcons.arrowsClockwise,
                      size: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 75),
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
                  ),
                ],
              ),
            ),
            const ViewSettingView(),
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
                text: 'Apply',
                onClick: () {
                  _hideViewSettingsSlider();
                  if (widget.onViewSettingApplied != null) {
                    widget.onViewSettingApplied!();
                  }
                },
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
    });
  }

  void _hideViewSettingsSlider() {
    setState(() {
      positionRightForViewSettingsSlider =
          -MediaQuery.of(context).size.width / 4;
    });
  }

  void _showFilterView() {
    setState(() {
      filterViewShow = true;
    });
  }

  void _hideFilterView() {
    setState(() {
      filterViewShow = false;
    });
  }

  void _showDetailsSlider() {
    setState(() {
      positionRightForDetailsSlider = 0;
      positionRightForViewSettingsSlider =
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
