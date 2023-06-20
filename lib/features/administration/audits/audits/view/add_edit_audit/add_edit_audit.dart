import '/common_libraries.dart';

class AddEditAuditView extends StatelessWidget {
  final String? auditId;
  final String? view;
  const AddEditAuditView({
    super.key,
    this.auditId,
    this.view,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditAuditBloc(context),
      child: AddEditAuditWidget(auditId: auditId),
    );
  }
}

class AddEditAuditWidget extends StatefulWidget {
  final String? auditId;
  final String? view;
  const AddEditAuditWidget({
    super.key,
    this.auditId,
    this.view,
  });

  @override
  State<AddEditAuditWidget> createState() => _AddEditAuditWidgetState();
}

class _AddEditAuditWidgetState extends State<AddEditAuditWidget> {
  late AddEditAuditBloc addEditAuditBloc;

  static String pageLabel = 'audit';

  @override
  void initState() {
    // addEditAuditBloc = context.read()..add(AddEditAuditRegionListLoaded());
    if (widget.auditId != null) {
      addEditAuditBloc.add(AddEditAuditLoaded(id: widget.auditId!));
    }

    super.initState();
  }

  // Map<String, Widget> get tabItems => widget.auditId != null
  //     ? {
  //         'Audit Template':
  //             AssignTemplatesToAuditView(auditId: widget.auditId!),
  //       }
  //     : {};

  @override
  Widget build(BuildContext context) {
    return Container();
    // return BlocConsumer<AddEditAuditBloc, AddEditAuditState>(
    //   listener: (context, state) {
    //     if (state.status == EntityStatus.success) {
    //       CustomNotification(
    //         context: context,
    //         notifyType: NotifyType.success,
    //         content: state.message,
    //       ).showNotification();
    //       if (widget.auditId == null) {
    //         GoRouter.of(context)
    //             .go('/audits/edit/${state.createdAuditId}?view=created');
    //       }
    //     }
    //     if (state.status == EntityStatus.failure) {
    //       CustomNotification(
    //         context: context,
    //         notifyType: NotifyType.error,
    //         content: state.message,
    //       ).showNotification();
    //     }
    //   },
    //   builder: (context, state) {
    //     return AddEditEntityTemplate(
    //       label: pageLabel,
    //       id: widget.auditId,
    //       selectedEntity: state.loadedAudit,
    //       addEntity: () => addEditAuditBloc.add(AddEditAuditAdded()),
    //       editEntity: () => addEditAuditBloc
    //           .add(AddEditAuditEdited(id: widget.auditId ?? '')),
    //       crudStatus: state.status,
    //       tabItems: tabItems,
    //       view: widget.view,
    //       // formDirty: state.formDirty,
    //       // child: const AddEditTemplateFormView(),
    //     );
    //   },
    // );
  }
}
