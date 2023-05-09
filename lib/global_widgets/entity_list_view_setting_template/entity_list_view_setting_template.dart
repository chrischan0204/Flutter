import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:safety_eta/common_libraries.dart';

import 'widgets/view_setting_item.dart';
import 'widgets/view_setting_tab.dart';

class EntityListViewSettingView extends StatefulWidget {
  final VoidCallback onColumnAdded;
  final bool Function(Key, Key) onReorderCallback;
  final void Function(int, String) onColumnSelectCallback;
  final ValueChanged<int> onColumnDeletCallback;
  final List<ViewSettingItemData> viewSettingDisplayList;
  final List<ViewSettingItemData> viewSettingSortingList;
  final List<String> columns;
  const EntityListViewSettingView({
    super.key,
    required this.onColumnAdded,
    required this.onReorderCallback,
    required this.onColumnSelectCallback,
    required this.onColumnDeletCallback,
    required this.viewSettingDisplayList,
    required this.viewSettingSortingList,
    required this.columns,
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
                                  widget.viewSettingDisplayList.length + 1) {
                                return _buildAddButton();
                              } else if (index == 0) {
                                return _buildTab();
                              }
                              return ViewSettingItem(
                                data: widget.viewSettingDisplayList[index - 1],
                                isFirst: index == 1,
                                isLast: index ==
                                    widget.viewSettingDisplayList.length,
                                columns: widget.columns,
                                // displayColumnList: state.usedColumns,
                                selectedValue: widget
                                    .viewSettingDisplayList[index - 1]
                                    .selectedValue,
                                onChange: (value) => widget
                                    .onColumnSelectCallback(index - 1, value),
                                deleteItem: () =>
                                    widget.onColumnDeletCallback(index - 1),
                              );
                            },
                            childCount:
                                widget.viewSettingDisplayList.length + 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
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
                                  widget.viewSettingSortingList.length + 1) {
                                return _buildAddButton();
                              } else if (index == 0) {
                                return _buildTab();
                              }
                              return ViewSettingItem(
                                data: widget.viewSettingSortingList[index - 1],
                                isFirst: index == 1,
                                isLast: index ==
                                    widget.viewSettingSortingList.length,
                                columns: widget.columns,
                                // displayColumnList: state.usedColumns,
                                selectedValue: widget
                                    .viewSettingSortingList[index - 1]
                                    .selectedValue,
                                canSort: true,
                                onChange: (value) => widget
                                    .onColumnSelectCallback(index - 1, value),
                                deleteItem: () =>
                                    widget.onColumnDeletCallback(index - 1),
                              );
                            },
                            childCount:
                                widget.viewSettingSortingList.length + 2,
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

  TextButton _buildAddButton() {
    return TextButton(
      onPressed: () => widget.onColumnAdded(),
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
