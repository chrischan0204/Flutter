import '/common_libraries.dart';
import 'widgets/first_name_field.dart';
import 'widgets/revision_date_picker.dart';

class AddEditTemplateView extends StatefulWidget {
  final String? templateId;
  final String? view;
  const AddEditTemplateView({
    super.key,
    this.templateId,
    this.view,
  });

  @override
  State<AddEditTemplateView> createState() => _AddEditTemplateViewState();
}

class _AddEditTemplateViewState extends State<AddEditTemplateView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, addEditTemplateState) {
        token = addEditTemplateState.authUser?.token ?? '';
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => TemplatesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => AddEditTemplateBloc(
                        templatesRepository: RepositoryProvider.of(context),
                      )),
              BlocProvider(
                  create: (context) => TemplateDetailBloc(
                      templatesRepository: RepositoryProvider.of(context))),
            ],
            child: AddEditTemplateWidget(
              templateId: widget.templateId,
              view: widget.view,
            ),
          ),
        );
      },
    );
  }
}

class AddEditTemplateWidget extends StatefulWidget {
  final String? templateId;
  final String? view;

  const AddEditTemplateWidget({
    super.key,
    this.templateId,
    this.view,
  });

  @override
  State<AddEditTemplateWidget> createState() => _AddEditTemplateWidgetState();
}

class _AddEditTemplateWidgetState extends State<AddEditTemplateWidget> {
  late AddEditTemplateBloc addEditTemplateBloc;
  late TemplateDetailBloc templateDetailBloc;
  late RolesBloc rolesBloc;
  late SitesBloc sitesBloc;
  late TimeZonesBloc timeZoneBloc;

  TextEditingController descriptionController = TextEditingController();

  static String pageLabel = 'template';
  static String addButtonName = 'Add Items';

  bool isFirstInit = true;

  @override
  void initState() {
    addEditTemplateBloc = context.read();
    templateDetailBloc = context.read();

    if (widget.templateId != null) {
      templateDetailBloc.add(
          TemplateDetailTemplateLoadedById(templateId: widget.templateId!));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditTemplateBloc, AddEditTemplateState>(
      listener: (context, addEditTemplateState) {
        _checkCrudResult(addEditTemplateState, context);
      },
      builder: (context, addEditTemplateState) {
        return BlocBuilder<TemplateDetailBloc, TemplateDetailState>(
          builder: (context, templateDetailState) {
            return BlocListener<TemplateDetailBloc, TemplateDetailState>(
              listener: (context, state) {
                if (state.template != null) {
                  addEditTemplateBloc.add(AddEditTemplateDateChanged(
                      date: DateTime.parse(state.template!.revisionDate)));
                  addEditTemplateBloc.add(AddEditTemplateDescriptionChanged(
                      description: state.template!.name!));
                  addEditTemplateBloc.add(AddEditTemplateUsedInAudit(
                      usedInAudit: state.template!.usedInAudit));
                  addEditTemplateBloc.add(AddEditTemplateUsedInInspection(
                      usedInInspection: state.template!.usedInInspection));
                }
              },
              listenWhen: (previous, current) =>
                  previous.template != current.template,
              child: AddEditEntityTemplate(
                label: pageLabel,
                id: widget.templateId,
                selectedEntity: templateDetailState.template,
                addButtonName: addButtonName,
                addEntity: () => _addTemplate(addEditTemplateState),
                editEntity: () => _editTemplate(addEditTemplateState),
                crudStatus: addEditTemplateState.templateAddStatus,
                isCrudDataFill: _checkFormDataFill(addEditTemplateState),
                tabItems: _buildTabs(addEditTemplateState),
                tabWidth: 500,
                view: widget.view,
                child: Column(
                  children: [
                    const FirstNameField(),
                    const RevisionDatePicker(),
                    _buildUsedInCheckBoxes(addEditTemplateState)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _checkFormDataFill(AddEditTemplateState addEditTemplateState) {
    return widget.templateId == null
        ? addEditTemplateState.templateDetailFilled
        : true;
  }

  Map<String, Widget> _buildTabs(AddEditTemplateState addEditTemplateState) {
    if (widget.templateId != null) {
      return {
        'Template Details': Container(),
        'Categories/Items': Container(),
        '': Container(),
      };
    }
    return {};
  }

  void _checkCrudResult(
      AddEditTemplateState addEditTemplateState, BuildContext context) {
    if (addEditTemplateState.templateAddStatus.isSuccess ||
        addEditTemplateState.templateEditStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: addEditTemplateState.message,
      ).showNotification();
      if (widget.templateId == null) {
        GoRouter.of(context).go(
            '/templates/designer/${addEditTemplateState.createdTemplateId}');
      }
    }
  }



  FormItem _buildUsedInCheckBoxes(AddEditTemplateState addEditTemplateState) {
    return FormItem(
      label: 'Used in',
      content: Row(
        children: [
          Checkbox(
            value: addEditTemplateState.usedInAudit,
            onChanged: (usedInAudit) =>
                addEditTemplateBloc.add(AddEditTemplateUsedInAudit(
              usedInAudit: usedInAudit!,
            )),
          ),
          const SizedBox(width: 5),
          const Text('Audits', style: TextStyle(fontSize: 12)),
        ],
      ),
      sideContent: Row(
        children: [
          Checkbox(
            value: addEditTemplateState.usedInInspection,
            onChanged: (usedInInspection) =>
                addEditTemplateBloc.add(AddEditTemplateUsedInInspection(
              usedInInspection: usedInInspection!,
            )),
          ),
          const SizedBox(width: 5),
          const Text('Inspections', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _addTemplate(AddEditTemplateState addEditTemplateState) =>
      addEditTemplateBloc.add(AddEditTemplateTemplateAdded());

  void _editTemplate(AddEditTemplateState addEditTemplateState) {
    // addEditTemplateBloc
    //       .add(AddEditTemplateTemplateEdited(templateId: widget.templateId!))
  }
}
