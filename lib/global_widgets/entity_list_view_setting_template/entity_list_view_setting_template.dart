import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:safety_eta/common_libraries.dart';

import 'widgets/view_setting_item.dart';
import 'widgets/view_setting_tab.dart';

class EntityListViewSettingView extends StatefulWidget {
  final VoidCallback onDisplayColumnAdded;
  final bool Function(Key, Key) onDisplayColumnOrderChanged;
  final void Function(ViewSettingItemData, ViewSettingColumn)
      onDisplayColumnSelected;
  final ValueChanged<ViewSettingItemData> onDisplayColumnDeleted;
  final VoidCallback onSortingColumnAdded;
  final bool Function(Key, Key) onSortingColumnOrderChanged;
  final void Function(ViewSettingItemData, ViewSettingColumn)
      onSortingColumnSelected;
  final ValueChanged<ViewSettingItemData> onSortingColumnDeleted;
  final List<ViewSettingItemData> viewSettingDisplayColumnList;
  final List<ViewSettingItemData> viewSettingSortingColumnList;
  final List<ViewSettingColumn> columns;
  final List<ViewSettingColumn> usefulDisplayColumns;
  final List<ViewSettingColumn> usefulSortingColumns;
  final void Function(ViewSettingItemData, String) onSortDirectionChanged;
  const EntityListViewSettingView({
    super.key,
    required this.onDisplayColumnAdded,
    required this.onDisplayColumnOrderChanged,
    required this.onDisplayColumnSelected,
    required this.onDisplayColumnDeleted,
    required this.onSortingColumnAdded,
    required this.onSortingColumnOrderChanged,
    required this.onSortingColumnSelected,
    required this.onSortingColumnDeleted,
    required this.viewSettingDisplayColumnList,
    required this.viewSettingSortingColumnList,
    required this.columns,
    required this.usefulDisplayColumns,
    required this.usefulSortingColumns,
    required this.onSortDirectionChanged,
  });

  @override
  State<EntityListViewSettingView> createState() =>
      _EntityListViewSettingViewState();
}

class _EntityListViewSettingViewState extends State<EntityListViewSettingView> {
  bool isDisplay = true;
  int addedDisplayColumnCount = 0;
  int addedSortingColumnCount = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              if (isDisplay) {
                return _buildDisplayColumnList(context);
              } else {
                return _buildSortingColumnList(context);
              }
            }),
          ),
        ],
      ),
    );
  }

  ReorderableList _buildSortingColumnList(BuildContext context) {
    return ReorderableList(
      onReorder: widget.onSortingColumnOrderChanged,
      onReorderDone: (draggedItem) {},
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == widget.viewSettingSortingColumnList.length + 1) {
                    return _buildAddButton(false);
                  } else if (index == 0) {
                    return _buildTab();
                  }
                  return ViewSettingItem(
                    data: widget.viewSettingSortingColumnList[index - 1],
                    isFirst: index == 1,
                    isLast: index == widget.viewSettingSortingColumnList.length,
                    columns: widget.columns,
                    selectedValue: widget
                        .viewSettingSortingColumnList[index - 1].selectedValue,
                    canSort: true,
                    sortDirection: widget
                        .viewSettingSortingColumnList[index - 1].sortDirection,
                    usefulColumns: widget.usefulSortingColumns,
                    onSortChanged: widget
                                .viewSettingSortingColumnList[index - 1]
                                .selectedValue ==
                            null
                        ? null
                        : (value) => widget.onSortDirectionChanged(
                            widget.viewSettingSortingColumnList[index - 1],
                            value),
                    onChange: (value) => widget.onSortingColumnSelected(
                        widget.viewSettingSortingColumnList[index - 1], value),
                    deleteItem: () => widget.onSortingColumnDeleted(
                        widget.viewSettingSortingColumnList[index - 1]),
                  );
                },
                childCount: widget.viewSettingSortingColumnList.length + 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ReorderableList _buildDisplayColumnList(BuildContext context) {
    return ReorderableList(
      onReorder: widget.onDisplayColumnOrderChanged,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index == widget.viewSettingDisplayColumnList.length + 1) {
                    return _buildAddButton(true);
                  } else if (index == 0) {
                    return _buildTab();
                  }
                  return ViewSettingItem(
                    data: widget.viewSettingDisplayColumnList[index - 1],
                    isFirst: index == 1,
                    isLast: index == widget.viewSettingDisplayColumnList.length,
                    columns: widget.columns,
                    usefulColumns: widget.usefulDisplayColumns,
                    selectedValue: widget
                        .viewSettingDisplayColumnList[index - 1].selectedValue,
                    onChange: (value) => widget.onDisplayColumnSelected(
                        widget.viewSettingDisplayColumnList[index - 1], value),
                    deleteItem: () => widget.onDisplayColumnDeleted(
                        widget.viewSettingDisplayColumnList[index - 1]),
                  );
                },
                childCount: widget.viewSettingDisplayColumnList.length + 2,
              ),
            ),
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
      onPressed: () => isDisplay
          ? widget.onDisplayColumnAdded()
          : widget.onSortingColumnAdded(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.regular.plus,
              size: 26,
            ),
            const SizedBox(width: 5),
            const Text('Add a column'),
          ],
        ),
      ),
    );
  }
}
