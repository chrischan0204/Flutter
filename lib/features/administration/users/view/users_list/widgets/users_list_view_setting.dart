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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListViewSettingBloc, UserListViewSettingState>(
      listener: (context, state) {
        if (state.viewSettingSaveStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: 'User view setting saved',
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.viewSettingSaveStatus != current.viewSettingSaveStatus,
      builder: (context, state) {
        if (state.viewSettingLoadStatus.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Loader(),
          );
        }
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
