import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';

import '/common_libraries.dart';

class ViewSettingItem extends StatefulWidget {
  const ViewSettingItem({
    Key? key,
    required this.data,
    required this.isFirst,
    required this.isLast,
    required this.deleteItem,
    required this.onChange,
    this.selectedValue,
    this.columns = const [],
    this.displayColumnList = const [],
    this.canSort = false,
    this.onSortChanged,
    this.sortDirection = 'asc',
  }) : super(key: key);

  final ViewSettingItemData data;
  final bool isFirst;
  final bool isLast;
  final VoidCallback deleteItem;
  final ValueChanged<ViewSettingColumn> onChange;
  final String? selectedValue;
  final List<ViewSettingColumn> columns;
  final List<String> displayColumnList;
  final bool canSort;
  final ValueChanged<String>? onSortChanged;
  final String sortDirection;

  @override
  State<ViewSettingItem> createState() => _ItemState();
}

class _ItemState extends State<ViewSettingItem> {
  bool isHover = false;
  String? selectedValue;

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      decoration = const BoxDecoration(color: Color(0xD0FFFFFF));
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        border: Border(
            top: widget.isFirst && !placeholder
                ? Divider.createBorderSide(context) //
                : BorderSide.none,
            bottom: widget.isLast && placeholder
                ? BorderSide.none //
                : Divider.createBorderSide(context)),
        color: placeholder ? null : Colors.white,
      );
    }

    Widget content = Container(
      decoration: decoration,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Opacity(
          opacity: state == ReorderableItemState.placeholder ? 0.0 : 1.0,
          child: IntrinsicHeight(
            child: ReorderableListener(
              child: MouseRegion(
                onHover: (event) => setState(() => isHover = true),
                onExit: (event) => setState(() => isHover = false),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildDragHandle(state),
                    _buildSelectField(),
                    _buildSortButton(),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return content;
  }

  StatelessWidget _buildSortButton() {
    return widget.canSort
        ? IconButton(
            onPressed: () {
              if (widget.onSortChanged != null) {
                widget.onSortChanged!(
                    widget.sortDirection == 'asc' ? 'desc' : 'asc');
              }
            },
            icon: Icon(
              widget.sortDirection == 'asc'
                  ? PhosphorIcons.regular.arrowUp
                  : PhosphorIcons.regular.arrowDown,
              size: 20,
              color: Colors.blue,
            ))
        : Container();
  }

  Widget _buildDragHandle(ReorderableItemState state) {
    return state != ReorderableItemState.normal
        ? Container(
            width: 30,
            alignment: Alignment.center,
            color: const Color(0x08000000),
            child: Center(
              child: Icon(PhosphorIcons.regular.dotsSixVertical,
                  color: const Color(0xFF888888)),
            ),
          )
        : Container(width: 30);
  }

  IconButton _buildDeleteButton() {
    return IconButton(
      onPressed: () {
        if (!(widget.isFirst && widget.isLast)) {
          widget.deleteItem();
        }
      },
      icon: widget.isFirst && widget.isLast
          ? Tooltip(
              height: 20,
              message: 'At least one column is required.',
              padding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 10,
              ),
              child: Icon(
                PhosphorIcons.regular.info,
                color: Colors.blue,
                size: 20,
              ),
            )
          :  Icon(
              PhosphorIcons.regular.x,
              color: Colors.red,
              size: 20,
            ),
    );
  }

  Expanded _buildSelectField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
        child: Builder(
          builder: (context) {
            Map<String, dynamic> items = {};
            for (var column in widget.columns) {
              items.addEntries([MapEntry(column.title, column)]);
            }
            return CustomSingleSelect(
              items: items,
              hint: 'Select Column',
              selectedValue: widget.selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value.key;
                });
                if (widget.displayColumnList.isNotEmpty &&
                    widget.displayColumnList.contains(value.key)) {}
                widget.onChange(value.value);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableItem(
      key: widget.data.key, //
      childBuilder: _buildChild,
    );
  }
}
