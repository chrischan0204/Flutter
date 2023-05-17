import '/common_libraries.dart';

class ViewSettingView extends StatefulWidget {
  const ViewSettingView({super.key});

  @override
  State<ViewSettingView> createState() =>
      _ViewSettingViewState();
}

class _ViewSettingViewState extends State<ViewSettingView> {
  late ViewSettingBloc viewSettingBloc;

  @override
  void initState() {
    viewSettingBloc = context.read();
    super.initState();
  }

  bool _reorderDisplayColumnCallback(Key item, Key newPosition) {
    int draggingIndex =
        viewSettingBloc.state.indexOfViewSettingDisplayColumnList(item);
    int newPositionIndex = viewSettingBloc.state
        .indexOfViewSettingDisplayColumnList(newPosition);

    viewSettingBloc.add(ViewSettingDisplayColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  bool _reorderSortingColumnCallback(Key item, Key newPosition) {
    int draggingIndex =
        viewSettingBloc.state.indexOfViewSettingSortingColumnList(item);
    int newPositionIndex = viewSettingBloc.state
        .indexOfViewSettingSortingColumnList(newPosition);

    viewSettingBloc.add(ViewSettingSortingColumnOrderChanged(
      draggingIndex: draggingIndex,
      newPositionIndex: newPositionIndex,
    ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ViewSettingBloc, ViewSettingState>(
      listener: (context, state) {
        if (state.viewSettingSaveStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: 'View setting saved',
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
          onDisplayColumnAdded: () => viewSettingBloc
              .add(ViewSettingDisplayColumnAdded()),
          onDisplayColumnOrderChanged: _reorderDisplayColumnCallback,
          onDisplayColumnSelected: (column, value) => viewSettingBloc
              .add(ViewSettingDisplayColumnSelected(
            column: column,
            selectedValue: value,
          )),
          onDisplayColumnDeleted: (column) => viewSettingBloc
              .add(ViewSettingDisplayColumnDeleted(column: column)),
          viewSettingDisplayColumnList:
              state.undeletedViewSettingDisplayColumnList,
          viewSettingSortingColumnList:
              state.undeletedViewSettingSortingColumnList,
          columns: state.columns,
          onSortingColumnAdded: () => viewSettingBloc
              .add(ViewSettingSortingColumnAdded()),
          onSortingColumnDeleted: (column) => viewSettingBloc
              .add(ViewSettingSortingColumnDeleted(column: column)),
          onSortingColumnOrderChanged: _reorderSortingColumnCallback,
          onSortingColumnSelected: (column, value) => viewSettingBloc
              .add(ViewSettingSortingColumnSelected(
            column: column,
            selectedValue: value,
          )),
          onSortDirectionChanged: (column, value) => viewSettingBloc
              .add(ViewSettingSortingColumnSortDirectionChanged(
            column: column,
            sortDirection: value,
          )),
        );
      },
    );
  }
}
