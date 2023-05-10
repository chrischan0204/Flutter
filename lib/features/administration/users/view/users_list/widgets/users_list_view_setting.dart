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

  bool _reorderDisplayColumnCallback(Key item, Key newPosition) {
    int draggingIndex =
        userListViewSettingBloc.state.indexOfViewSettingDisplayColumnList(item);
    int newPositionIndex = userListViewSettingBloc.state
        .indexOfViewSettingDisplayColumnList(newPosition);

    userListViewSettingBloc.add(UserListViewSettingDisplayColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  bool _reorderSortingColumnCallback(Key item, Key newPosition) {
    int draggingIndex =
        userListViewSettingBloc.state.indexOfViewSettingSortingColumnList(item);
    int newPositionIndex = userListViewSettingBloc.state
        .indexOfViewSettingSortingColumnList(newPosition);

    userListViewSettingBloc.add(UserListViewSettingSortingColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  void _reorderDone(Key item) {
    // final draggedItem =
    //     userListViewSettingBloc.state.viewSettingDisplayColumnList[
    //         userListViewSettingBloc.state.indexOf(item)];
    // debugPrint("Reordering finished for ${draggedItem.selectedValue}}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListViewSettingBloc, UserListViewSettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return EntityListViewSettingView(
          onDisplayColumnAdded: () => userListViewSettingBloc
              .add(UserListViewSettingDisplayColumnAdded()),
          onDisplayColumnOrderChanged: _reorderDisplayColumnCallback,
          onDisplayColumnSelected: (column, value) => userListViewSettingBloc
              .add(UserListViewSettingDisplayColumnSelected(
            column: column,
            selectedValue: value,
          )),
          onDisplayColumnDeleted: (column) => userListViewSettingBloc
              .add(UserListViewSettingDisplayColumnDeleted(column: column)),
          viewSettingDisplayColumnList:
              state.undeletedViewSettingDisplayColumnList,
          viewSettingSortingColumnList:
              state.undeletedViewSettingSortingColumnList,
          columns: state.columns,
          onSortingColumnAdded: () => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnAdded()),
          onSortingColumnDeleted: (column) => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnDeleted(column: column)),
          onSortingColumnOrderChanged: _reorderSortingColumnCallback,
          onSortingColumnSelected: (column, value) => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnSelected(
            column: column,
            selectedValue: value,
          )),
          onSortDirectionChanged: (column, value) => userListViewSettingBloc
              .add(UserListViewSettingSortingColumnSortDirectionChanged(
            column: column,
            sortDirection: value,
          )),
        );
      },
    );
  }
}
