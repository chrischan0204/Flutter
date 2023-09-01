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
      create: (context) => AddEditAuditBloc(context, auditId: auditId),
      child: AddEditAuditWidget(
        auditId: auditId,
        view: view,
      ),
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
    addEditAuditBloc = context.read();

    if (widget.auditId != null) {
      addEditAuditBloc.add(AddEditAuditLoaded(id: widget.auditId!));
    } else {
      addEditAuditBloc.add(AddEditAuditSiteListLoaded());
    }

    if (widget.auditId != null) {
      context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
            collapsedItem: 'audits/edit',
            force: true,
          ));
    }

    super.initState();
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
          } else {
            if (state.isWithConfirmation) {
              context.go('/audits/show/${widget.auditId}');
            }
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
        if (state.status.isLoading &&
            state.isWithConfirmation &&
            widget.auditId != null) {
          return WaitingApproveEditAuditView(
            auditNumber: state.loadedAudit?.auditNumber ?? '',
          );
        }

        if (state.isWithConfirmation && widget.auditId != null) {
          return ApproveEditAuditView(auditId: widget.auditId!);
        }
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.auditId,
          selectedEntity: state.loadedAudit,
          addEntity: () => addEditAuditBloc.add(AddEditAuditAdded(
              userId:
                  context.read<AuthBloc>().state.authUser?.id ?? emptyGuid)),
          editEntity: () {
            if (state.isNeedConfirmation) {
              context.read<AddEditAuditBloc>().add(
                  const AddEditIsWithConfirmationChanged(
                      isWithConfirmation: true));
            } else {
              addEditAuditBloc.add(AddEditAuditEdited(
                  id: widget.auditId ?? '',
                  userId: context.read<AuthBloc>().state.authUser!.id));
            }
          },
          crudStatus: state.status,
          tabItems: tabItems,
          view: widget.view,
          onTabClick: (index) async {
            if (index == 1) {
              bool success = false;

              if (context.read<FormDirtyBloc>().state.isDirty) {
                await CustomAlert(
                  context: context,
                  width: MediaQuery.of(context).size.width / 4,
                  dialogType: DialogType.question,
                  title: 'Confirm',
                  description:
                      'Data that was entered will be lost ..... Proceed?',
                  btnCancelOnPress: () => success = false,
                  btnOkOnPress: () {
                    success = true;
                    context
                        .read<FormDirtyBloc>()
                        .add(const FormDirtyChanged(isDirty: false));
                  },
                  btnOkText: 'Proceed',
                ).show();
              } else {
                success = true;
              }
              return success;
            } else {
              return true;
            }
          },
          formDirty: state.formDirty,
          addButtonName: addButtonName,
          child: const AddEditAuditFormView(),
        );
      },
    );
  }
}
