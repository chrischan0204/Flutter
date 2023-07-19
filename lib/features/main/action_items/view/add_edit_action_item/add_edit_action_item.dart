import '/common_libraries.dart';
import 'widgets/widgets.dart';

class AddEditActionItemView extends StatelessWidget {
  final String? actionItemId;
  final String? view;
  const AddEditActionItemView({
    super.key,
    this.actionItemId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditActionItemBloc(context),
      child: AddEditActionItemWidget(
        actionItemId: actionItemId,
        view: view,
      ),
    );
  }
}

class AddEditActionItemWidget extends StatefulWidget {
  final String? actionItemId;
  final String? view;
  const AddEditActionItemWidget({
    super.key,
    this.actionItemId,
    this.view,
  });

  @override
  State<AddEditActionItemWidget> createState() =>
      _AddEditActionItemWidgetState();
}

class _AddEditActionItemWidgetState extends State<AddEditActionItemWidget> {
  late AddEditActionItemBloc addEditActionItemBloc;

  static String pageLabel = 'action item';

  @override
  void initState() {
    addEditActionItemBloc = context.read()
      ..add(AddEditActionItemAwarenessCategoryListLoaded())
      ..add(AddEditActionItemSiteListLoaded());

    if (widget.actionItemId != null) {
      addEditActionItemBloc
          .add(AddEditActionItemLoaded(actionItemId: widget.actionItemId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditActionItemBloc, AddEditActionItemState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          if (widget.actionItemId == null) {
            context.go('/action-items');
          }
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.actionItemId,
          selectedEntity: state.actionItem,
          addEntity: () => addEditActionItemBloc.add(AddEditActionItemAdded()),
          editEntity: () =>
              addEditActionItemBloc.add(AddEditActionItemEdited()),
          crudStatus: state.status,
          view: widget.view,
          formDirty: state.formDirty,
          child: AddEditActionItemFormView(),
        );
      },
    );
  }
}
