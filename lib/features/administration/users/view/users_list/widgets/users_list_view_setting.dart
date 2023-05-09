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
    userListViewSettingBloc = context.read();
    super.initState();
  }

  int _indexOfKey(Key key) {
    return userListViewSettingBloc.state.viewSettingDisplayList
        .indexWhere((d) => d.key == key);
  }

  bool _reorderCallback(Key item, Key newPosition) {
    int draggingIndex = _indexOfKey(item);
    int newPositionIndex = _indexOfKey(newPosition);

    userListViewSettingBloc.add(UserListViewSettingDisplayOrderChanged(
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
    return BlocBuilder<UserListViewSettingBloc, UserListViewSettingState>(
      builder: (context, state) {
        return EntityListViewSettingView(
          onColumnAdded: () =>
              userListViewSettingBloc.add(UserListViewSettingDisplayAdded()),
          onReorderCallback: _reorderCallback,
          onColumnSelectCallback: (index, value) =>
              userListViewSettingBloc.add(UserListViewSettingDisplaySelected(
            columnIndex: index,
            selectedValue: value,
          )),
          onColumnDeletCallback: (index) => userListViewSettingBloc
              .add(UserListViewSettingDisplayDeleted(columnIndex: index)),
          viewSettingDisplayList: state.viewSettingDisplayList,
          viewSettingSortingList: state.viewSettingSortingList,
          columns: state.columns,
        );
      },
    );
  }
}
