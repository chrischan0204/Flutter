import '/common_libraries.dart';
import 'widgets/widgets.dart';

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

  static String addButtonName = 'Create & add questions';

  Map<String, Widget> get tabItems => widget.auditId != null
      ? {
          'Audit questions': AuditQuestionsView(auditId: widget.auditId!),
        }
      : {};

  @override
  void initState() {
    addEditAuditBloc = context.read()
      ..add(AddEditAuditSiteListLoaded())
      ..add(AddEditAuditSiteTemplateLoaded())
      ..add(AddEditAuditProjectListLoaded());

    if (widget.auditId != null) {
      addEditAuditBloc.add(AddEditAuditLoaded(id: widget.auditId!));
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.auditId != null) {
      context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
            collapsedItem: 'audits/edit',
            force: true,
          ));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditAuditBloc, AddEditAuditState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();
          if (widget.auditId == null) {
            GoRouter.of(context)
                .go('/audits/edit/${state.createdAuditId}?view=created');
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
          id: widget.auditId,
          selectedEntity: state.loadedAudit,
          addEntity: () => addEditAuditBloc.add(AddEditAuditAdded(
              userId:
                  context.read<AuthBloc>().state.authUser?.id ?? emptyGuid)),
          editEntity: () => addEditAuditBloc
              .add(AddEditAuditEdited(id: widget.auditId ?? '')),
          crudStatus: state.status,
          tabItems: tabItems,
          view: widget.view,
          formDirty: state.formDirty,
          addButtonName: addButtonName,
          child: const AddEditAuditFormView(),
        );
      },
    );
  }
}
