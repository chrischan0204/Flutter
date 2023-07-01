import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ActionItemDetailView extends StatelessWidget {
  final String actionItemId;
  const ActionItemDetailView({
    super.key,
    required this.actionItemId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActionItemDetailBloc(context),
      child: ActionItemDetailWidget(actionItemId: actionItemId),
    );
  }
}

class ActionItemDetailWidget extends StatefulWidget {
  final String actionItemId;
  const ActionItemDetailWidget({
    super.key,
    required this.actionItemId,
  });

  @override
  State<ActionItemDetailWidget> createState() => _ActionItemDetailViewState();
}

class _ActionItemDetailViewState extends State<ActionItemDetailWidget> {
  static String pageTitle = 'Action Item';
  static String pageLabel = 'action item';

  @override
  void initState() {
    context
        .read<ActionItemDetailBloc>()
        .add(ActionItemDetailLoaded(actionItemId: widget.actionItemId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActionItemDetailBloc, ActionItemDetailState>(
      listener: (context, state) {
        if (state.actionItemDeleteStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
        }
        if (state.actionItemDeleteStatus.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.actionItemDeleteStatus != current.actionItemDeleteStatus,
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => context.read<ActionItemDetailBloc>().add(
              ActionItemDetailActionItemDeleted(
                  actionItemId: widget.actionItemId)),
          entity: state.actionItem,
          crudStatus: state.actionItemDeleteStatus,
          isEditable: false,
          isShowName: false,

          customDetailWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(flex: 2, child: ActionItemInformationView()),
              Expanded(flex: 3, child: ParentInformationView()),
              Expanded(flex: 2, child: AssestsView())
            ],
          ),
          // descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
