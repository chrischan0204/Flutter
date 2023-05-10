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
    userListViewSettingBloc = context.read()..add(UserListViewSettingLoaded());
    super.initState();
  }

  int _indexOfKey(Key key) {
    return userListViewSettingBloc.state.viewSettingDisplayList
        .indexWhere((d) => d.key == key);
  }

  bool _reorderDisplayColumnCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    userListViewSettingBloc.add(UserListViewSettingDisplayOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  bool _reorderSortingColumnCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    userListViewSettingBloc.add(UserListViewSettingSortingOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  void _reorderDone(Key item) {
    final draggedItem =
        userListViewSettingBloc.state.viewSettingDisplayList[_indexOfKey(item)];
    debugPrint("Reordering finished for ${draggedItem.selectedValue}}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListViewSettingBloc, UserListViewSettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return EntityListViewSettingView(
          onColumnAdded: () =>
              userListViewSettingBloc.add(UserListViewSettingDisplayAdded()),
          onReorderCallback: _reorderDisplayColumnCallback,
          onColumnSelectCallback: (index, value) =>
              userListViewSettingBloc.add(UserListViewSettingDisplaySelected(
            columnIndex: index,
            selectedValue: value,
          )),
          onColumnDeleteCallback: (index) => userListViewSettingBloc
              .add(UserListViewSettingDisplayDeleted(columnIndex: index)),
          viewSettingDisplayList: state.viewSettingDisplayList,
          viewSettingSortingList: state.viewSettingSortingList,
          columns: state.columns,
          onSortingAdded: () =>
              userListViewSettingBloc.add(UserListViewSettingSortingAdded()),
          onSortingDeleteCallback: (index) => userListViewSettingBloc
              .add(UserListViewSettingSortingDeleted(columnIndex: index)),
          onSortingReorderCallback: _reorderSortingColumnCallback,
          onSortingSelectCallback: (index, value) =>
              userListViewSettingBloc.add(UserListViewSettingSortingSelected(
            columnIndex: index,
            selectedValue: value,
          )),
        );
      },
    );
  }
}
