import '/common_libraries.dart';
import 'package:strings/strings.dart';

class EntityListTemplate extends StatefulWidget {
  final List<Entity> entities;
  final VoidCallback? onViewSettingApplied;
  final ValueChanged<String>? onFilterSaved;
  final void Function([String?, bool?])? onFilterApplied;
  final bool entityListLoadStatusLoading;
  final bool entityDetailLoadStatusLoading;
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
  final void Function(int pageNum, int pageRow)? onPaginate;
  final int totalRows;
  final bool isShowName;
  const EntityListTemplate({
    super.key,
    required this.title,
    this.onViewSettingApplied,
    this.onFilterSaved,
    this.onFilterApplied,
    required this.label,
    required this.onRowClick,
    this.onIncludeDeletedChanged,
    this.entityListLoadStatusLoading = true,
    this.entityDetailLoadStatusLoading = false,
    this.entities = const [],
    this.selectedEntity,
    this.description = '',
    this.emptyMessage = '',
    this.showTableHeaderButtons = false,
    this.onTableSorted,
    this.newIconData,
    this.columns = const [],
    this.viewName,
    this.onPaginate,
    this.totalRows = 0,
    this.isShowName = true,
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
  late ViewSettingBloc viewSettingBloc;
  late PaginationBloc paginationBloc;

  String token = '';

  Map<String, double> columnWidths = {};
  List<String> columns = [];

  @override
  void initState() {
    filterSettingBloc = context.read();
    viewSettingBloc = context.read();
    paginationBloc = context.read();
    if (widget.viewName != null) {
      filterSettingBloc.add(FilterSettingInit(viewName: widget.viewName!));
    }

    columns = widget.entities.isNotEmpty
        ? (widget.entities[0].columns.isNotEmpty
            ? widget.entities[0].columns
            : widget.entities[0].tableItemsToMap().keys.toList())
        : [];

    for (final column in columns) {
      columnWidths.addEntries([MapEntry(column, double.nan)]);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    positionRightForViewSettingsSlider = positionRightForDetailsSlider =
        -MediaQuery.of(context).size.width / 4 - 10;
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildHeader(),
                            if (widget.showTableHeaderButtons)
                              _buildTableHeader()
                          ],
                        ),
                      ),
                    ),
                    if (filterViewShow && widget.viewName != null)
                      FilterSettingView(
                        viewName: widget.viewName!,
                        onFilterOptionClosed: () => _hideFilterView(),
                        onFilterApplied: (filterId, [withoutSave]) {
                          if (widget.onFilterApplied != null) {
                            paginationBloc.add(
                                const PaginationSelectedPageNumChanged(
                                    selectedPageNum: 1));
                            widget.onFilterApplied!(filterId, withoutSave);
                          }
                        },
                        onFilterSaved: (filterId) {
                          if (widget.onFilterSaved != null) {
                            paginationBloc.add(
                                const PaginationSelectedPageNumChanged(
                                    selectedPageNum: 1));
                            widget.onFilterSaved!(filterId);
                          }
                        },
                      ),
                    _buildTableView(),
                    PaginationView(
                      totalRows: widget.totalRows,
                      onPaginate: (pageNum, pageRow) {
                        if (widget.onPaginate != null) {
                          widget.onPaginate!(pageNum, pageRow);
                        }
                      },
                    )
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
            // vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: textSemiBold18,
                  ),
                  const SizedBox(width: 10),
                  if (widget.description.isNotEmpty)
                    Description(description: widget.description)
                ],
              ),
              CustomButton(
                backgroundColor: warnColor,
                hoverBackgroundColor: warnHoverColor,
                iconData: widget.newIconData ?? PhosphorIcons.regular.plus,
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

  Widget _buildTableView() {
    columns = widget.entities.isNotEmpty
        ? (widget.entities[0].columns.isNotEmpty
            ? widget.entities[0].columns
            : widget.entities[0].tableItemsToMap().keys.toList())
        : [];

    for (final column in columns) {
      if (!columnWidths.containsKey(column)) {
        columnWidths.addEntries([MapEntry(column, double.nan)]);
      }
    }
    return Expanded(
      child: Card(
        elevation: 3,
        child: widget.entityListLoadStatusLoading
            ? const Center(
                child: Loader(),
              )
            : Container(
                constraints: const BoxConstraints(minHeight: 300),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 12,
                ),
                width: double.infinity,
                child: DataTableView(
                  entities: widget.entities,
                  columns: columns,
                  emptyMessage: widget.emptyMessage,
                  columnWidths: columnWidths,
                  onColumnSizedUpated: (value) {
                    setState(() => columnWidths[value.key] = value.value);
                  },
                  onRowClick: (entity) {
                    if (!entity.deleted) {
                      _showDetailsSlider();
                      setState(() {
                        selectedId = entity.id!;
                      });
                      widget.onRowClick(entity);
                    }
                  },
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
                    iconData: PhosphorIcons.regular.funnel,
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
                    iconData: PhosphorIcons.regular.slidersHorizontal,
                    label: 'View Settings',
                    color: warnColor,
                    onClick: () {
                      viewSettingBloc
                          .add(ViewSettingLoaded(viewName: widget.viewName!));
                      _showViewSettingsSlider();
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  HeaderButton(
                    iconData: PhosphorIcons.regular.chartBar,
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
                  BlocBuilder<FilterSettingBloc, FilterSettingState>(
                    builder: (context, state) {
                      final filterNotApplied =
                          state.appliedUserFilterSetting != null &&
                              !state.appliedUserFilterSetting!.isNew;
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: filterNotApplied
                            ? BoxDecoration(
                                border: Border.all(
                                  color: primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              )
                            : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BlocConsumer<FilterSettingBloc, FilterSettingState>(
                              listener: (context, state) {
                                if (state.selectedUserFilterSetting != null) {
                                  if (widget.onFilterApplied != null) {
                                    widget.onFilterApplied!(
                                        state.selectedUserFilterSetting!.id);

                                    filterSettingBloc.add(
                                        FilterSettingAppliedUserFilterSettingChanged(
                                            appliedUserFilterSetting: state
                                                .selectedUserFilterSetting));
                                  }
                                }
                              },
                              listenWhen: (previous, current) =>
                                  previous.selectedUserFilterSetting == null &&
                                  previous.selectedUserFilterSetting !=
                                      current.selectedUserFilterSetting,
                              builder: (context, state) {
                                if (!filterNotApplied) {
                                  return Container();
                                }
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      PhosphorIcons.regular.funnel,
                                      size: 20,
                                      color: filterNotApplied
                                          ? primaryColor
                                          : Colors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      state
                                          .appliedUserFilterSetting!.filterName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: filterNotApplied
                                            ? primaryColor
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(width: 20),
                            BlocConsumer<FilterSettingBloc, FilterSettingState>(
                              listener: (context, state) {
                                if (widget.onFilterApplied != null) {
                                  widget.onFilterApplied!(emptyGuid);
                                }
                              },
                              listenWhen: (previous, current) =>
                                  previous.appliedUserFilterSetting != null &&
                                  previous.appliedUserFilterSetting !=
                                      current.appliedUserFilterSetting &&
                                  current.appliedUserFilterSetting == null,
                              builder: (context, state) {
                                return filterNotApplied
                                    ? GestureDetector(
                                        onTap: () {
                                          filterSettingBloc.add(
                                            const FilterSettingAppliedUserFilterSettingChanged(
                                                appliedUserFilterSetting: null),
                                          );
                                          paginationBloc.add(
                                              const PaginationSelectedPageNumChanged(
                                                  selectedPageNum: 1));
                                        },
                                        child: Icon(
                                          PhosphorIcons.regular.x,
                                          color: warnColor,
                                          size: 18,
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: includeDeleted,
                        onChanged: (value) {
                          if (widget.onIncludeDeletedChanged != null) {
                            filterSettingBloc.add(
                                FilterSettingIncludeDeletedChanged(
                                    includeDeleted: value!));
                            paginationBloc.add(
                                const PaginationSelectedPageNumChanged(
                                    selectedPageNum: 1));
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
                      )
                    ],
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    onPressed: () {
                      if (widget.onIncludeDeletedChanged != null) {
                        paginationBloc.add(
                            const PaginationSelectedPageNumChanged(
                                selectedPageNum: 1));
                        widget.onIncludeDeletedChanged!(includeDeleted);
                      }
                    },
                    icon: Icon(
                      PhosphorIcons.regular.arrowsClockwise,
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
      child: Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - topbarHeight),
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
                      icon: Icon(
                        PhosphorIcons.regular.arrowCircleRight,
                        size: 20,
                        color: const Color(0xffef4444),
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
                child: BlocConsumer<ViewSettingBloc, ViewSettingState>(
                  listener: (context, viewSettingState) {
                    if (widget.onViewSettingApplied != null) {
                      widget.onViewSettingApplied!();
                    }
                  },
                  listenWhen: (previous, current) =>
                      previous.viewSettingSaveStatus !=
                          current.viewSettingSaveStatus &&
                      current.viewSettingSaveStatus.isSuccess,
                  builder: (context, state) => CustomButton(
                    backgroundColor: const Color(0xff0c83ff),
                    hoverBackgroundColor: const Color(0xff0b76e6),
                    iconData: PhosphorIcons.regular.arrowRight,
                    text: 'Apply',
                    onClick: () {
                      if (!state.displayColumnAllFill) {
                        CustomNotification(
                                context: context,
                                notifyType: NotifyType.error,
                                content: 'Please select display column')
                            .showNotification();
                      } else if (!state.sortingColumnAllFill) {
                        CustomNotification(
                                context: context,
                                notifyType: NotifyType.error,
                                content: 'Please select sorting column')
                            .showNotification();
                      } else if (state.displayColumnAllFill &&
                          state.sortingColumnAllFill) {
                        _hideViewSettingsSlider();
                        if (widget.viewName != null) {
                          viewSettingBloc.add(
                              ViewSettingApplied(viewName: widget.viewName!));
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
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
      child: Card(
        elevation: 3,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height - topbarHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 30,
          ),
          color: Colors.white,
          child: SingleChildScrollView(
            child: widget.entityDetailLoadStatusLoading
                ? const Center(
                    child: Loader(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: insetx20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.isShowName
                                    ? (widget.selectedEntity != null
                                        ? widget.selectedEntity!.name ?? ''
                                        : '')
                                    : '${camelize(widget.label)} Details',
                                style: textSemiBold14,
                                maxLines: 3,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () => _hideDetailsSlider(),
                              icon: Icon(
                                PhosphorIcons.regular.arrowCircleRight,
                                size: 20,
                                color: const Color(0xffef4444),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ...widget.selectedEntity != null
                          ? widget.selectedEntity!
                              .sideDetailItemsToMap()
                              .entries
                              .map(
                                (detail) => DetailItem(
                                  label: detail.key,
                                  isTwoLine: detail.value is Map,
                                  content: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    child: CustomDataCell(
                                      data: detail.value is Map
                                          ? detail.value['content']
                                          : detail.value,
                                      maxLines: 1000,
                                    ),
                                  ),
                                ),
                              )
                              .toList()
                          : [],
                      widget.entityDetailLoadStatusLoading
                          ? Container()
                          : Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                      widget.entityDetailLoadStatusLoading
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 12,
                              ),
                              child: CustomButton(
                                backgroundColor: const Color(0xff0c83ff),
                                hoverBackgroundColor: const Color(0xff0b76e6),
                                iconData: PhosphorIcons.regular.arrowRight,
                                text: '${camelize(widget.label)} Details',
                                onClick: () {
                                  String location =
                                      GoRouter.of(context).location;
                                  int index = location.indexOf('/index');
                                  if (index != -1) {
                                    location =
                                        location.replaceRange(index, null, '');
                                  }

                                  GoRouter.of(context)
                                      .go('$location/show/$selectedId');
                                },
                              ),
                            ),
                    ],
                  ),
          ),
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
          -MediaQuery.of(context).size.width / 4 - 10;
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
          -MediaQuery.of(context).size.width / 4 - 10;
    });
  }

  void _hideDetailsSlider() {
    setState(() {
      positionRightForDetailsSlider =
          -MediaQuery.of(context).size.width / 4 - 10;
    });
  }
}
