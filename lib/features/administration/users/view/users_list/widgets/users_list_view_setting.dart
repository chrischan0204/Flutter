import '/common_libraries.dart';

class UserListViewSettingView extends StatefulWidget {
  const UserListViewSettingView({super.key});

  @override
  State<UserListViewSettingView> createState() =>
      _UserListViewSettingViewState();
}

class _UserListViewSettingViewState extends State<UserListViewSettingView> {
  late UserListViewSettingBloc userListViewSettingBloc;

  @override
  void initState() {
    userListViewSettingBloc = context.read()
      ..add(const UserListViewSettingLoaded(viewName: 'user'));
    super.initState();
  }

  int _indexOfKey(Key key) {
    return userListViewSettingBloc.state.viewSettingDisplayColumnList
        .indexWhere((d) => d.key == key);
  }

  bool _reorderDisplayColumnCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    userListViewSettingBloc.add(UserListViewSettingDisplayColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  bool _reorderSortingColumnCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    userListViewSettingBloc.add(UserListViewSettingSortingColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem =
        userListViewSettingBloc.state.viewSettingDisplayColumnList[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.selectedValue}}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListViewSettingBloc, UserListViewSettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return EntityListViewSettingView(
          onColumnAdded: () =>
              userListViewSettingBloc.add(UserListViewSettingDisplayColumnAdded()),
          onReorderCallback: _reorderDisplayColumnCallback,
          onColumnSelectCallback: (index, value) =>
              userListViewSettingBloc.add(UserListViewSettingDisplayColumnSelected(
            columnIndex: index,
            selectedValue: value,
          )),
          onColumnDeleteCallback: (index) => userListViewSettingBloc
              .add(UserListViewSettingDisplayColumnDeleted(columnIndex: index)),
          viewSettingDisplayColumnList: state.viewSettingDisplayColumnList,
          viewSettingSortingColumnList: state.viewSettingSortingColumnList,
          columns: state.columns,
          onSortingAdded: () =>
              userListViewSettingBloc.add(UserListViewSettingSortingColumnAdded()),
          onSortingDeleteCallback: (index) => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnDeleted(columnIndex: index)),
          onSortingReorderCallback: _reorderSortingColumnCallback,
          onSortingSelectCallback: (index, value) =>
              userListViewSettingBloc.add(UserListViewSettingSortingColumnSelected(
            columnIndex: index,
            selectedValue: value,
          )),
          onSortDirectionChanged: (index, value) => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnSortDirectionChanged(
            columnIndex: index,
            sortDirection: value,
          )),
        );
      },
    );
  }
}
