import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddActionItemView extends StatefulWidget {
  final String observationId;
  const AddActionItemView({
    super.key,
    required this.observationId,
  });

  @override
  State<AddActionItemView> createState() => _AddActionItemViewState();
}

class _AddActionItemViewState extends State<AddActionItemView> {
  @override
  void initState() {
    context
        .read<AddActionItemBloc>()
        .add(AddActionItemListLoaded(observationId: widget.observationId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          const AddActionItemHeaderView(),
          BlocConsumer<AddActionItemBloc, AddActionItemState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.success,
                  content: state.message,
                ).showNotification();
              } else if (state.status.isFailure) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.error,
                  content: state.message,
                ).showNotification();
              }
            },
            listenWhen: (previous, current) =>
                previous.status != current.status,
            builder: (context, state) {
              if (state.isEditing) {
                return const AddActionItemFormView();
              } else {
                if (state.actionItem == null) {
                  return const ActionItemListViewForObservation();
                } else {
                  return const ActionItemDetailViewForObservation();
                }
              }
            },
          )
        ],
      ),
    );
  }
}
