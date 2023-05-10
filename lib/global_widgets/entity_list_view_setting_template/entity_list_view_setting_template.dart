import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:safety_eta/common_libraries.dart';

import 'widgets/view_setting_item.dart';
import 'widgets/view_setting_tab.dart';

class EntityListViewSettingView extends StatefulWidget {
  final VoidCallback onColumnAdded;
  final bool Function(Key, Key) onReorderCallback;
  final void Function(int, ViewSettingColumn) onColumnSelectCallback;
  final ValueChanged<int> onColumnDeleteCallback;
  final VoidCallback onSortingAdded;
  final bool Function(Key, Key) onSortingReorderCallback;
  final void Function(int, ViewSettingColumn) onSortingSelectCallback;
  final ValueChanged<int> onSortingDeleteCallback;
  final List<ViewSettingItemData> viewSettingDisplayColumnList;
  final List<ViewSettingItemData> viewSettingSortingColumnList;
  final List<ViewSettingColumn> columns;
  final void Function(int, String) onSortDirectionChanged;
  const EntityListViewSettingView({
    super.key,
    required this.onColumnAdded,
    required this.onReorderCallback,
    required this.onColumnSelectCallback,
    required this.onColumnDeleteCallback,
    required this.onSortingAdded,
    required this.onSortingReorderCallback,
    required this.onSortingSelectCallback,
    required this.onSortingDeleteCallback,
    required this.viewSettingDisplayColumnList,
    required this.viewSettingSortingColumnList,
    required this.columns,
    required this.onSortDirectionChanged,
  });

  @override
  State<EntityListViewSettingView> createState() =>
      _EntityListViewSettingViewState();
}

class _EntityListViewSettingViewState extends State<EntityListViewSettingView> {
  bool isDisplay = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              if (isDisplay) {
                return ReorderableList(
                  onReorder: widget.onReorderCallback,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index ==
                                  widget.viewSettingDisplayColumnList.length + 1) {
                                return _buildAddButton(true);
                              } else if (index == 0) {
                                return _buildTab();
                              }
                              return ViewSettingItem(
                                data: widget.viewSettingDisplayColumnList[index - 1],
                                isFirst: index == 1,
                                isLast: index ==
                                    widget.viewSettingDisplayColumnList.length,
                                columns: widget.columns,
                                // displayColumnList: state.usedColumns,
                                selectedValue: widget
                                    .viewSettingDisplayColumnList[index - 1]
                                    .selectedValue
                                    ?.title,
                                onChange: (value) => widget
                                    .onColumnSelectCallback(index - 1, value),
                                deleteItem: () =>
                                    widget.onColumnDeleteCallback(index - 1),
                              );
                            },
                            childCount:
                                widget.viewSettingDisplayColumnList.length + 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ReorderableList(
                  onReorder: widget.onSortingReorderCallback,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index ==
                                  widget.viewSettingSortingColumnList.length + 1) {
                                return _buildAddButton(false);
                              } else if (index == 0) {
                                return _buildTab();
                              }
                              return ViewSettingItem(
                                data: widget.viewSettingSortingColumnList[index - 1],
                                isFirst: index == 1,
                                isLast: index ==
                                    widget.viewSettingSortingColumnList.length,
                                columns: widget.columns,
                                // displayColumnList: state.usedColumns,
                                selectedValue: widget
                                    .viewSettingSortingColumnList[index - 1]
                                    .selectedValue
                                    ?.title,
                                canSort: true,
                                sortDirection: widget
                                    .viewSettingSortingColumnList[index - 1]
                                    .sortDirection,
                                onSortChanged: (value) => widget
                                    .onSortDirectionChanged(index - 1, value),
                                onChange: (value) => widget
                                    .onSortingSelectCallback(index - 1, value),
                                deleteItem: () =>
                                    widget.onSortingDeleteCallback(index - 1),
                              );
                            },
                            childCount:
                                widget.viewSettingSortingColumnList.length + 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  ViewSettingTabView _buildTab() {
    return ViewSettingTabView(
      onChange: (tabIndex) => setState(() => isDisplay = tabIndex == 0),
    );
  }

  TextButton _buildAddButton(bool isDisplay) {
    return TextButton(
      onPressed: () =>
          isDisplay ? widget.onColumnAdded() : widget.onSortingAdded(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Icon(
              PhosphorIcons.plus,
              size: 26,
            ),
            SizedBox(width: 5),
            Text('Add a column'),
          ],
        ),
      ),
    );
  }
}
