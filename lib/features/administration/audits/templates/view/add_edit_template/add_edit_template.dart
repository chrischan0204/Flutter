import '/common_libraries.dart';
import 'widgets/widgets.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AddEditTemplateBloc(
                  templatesRepository: RepositoryProvider.of(context),
                )),
        BlocProvider(
            create: (context) => TemplateDetailBloc(
                templatesRepository: RepositoryProvider.of(context))),
        BlocProvider(
          create: (context) => TemplateDesignerBloc(
            templatesRepository: RepositoryProvider.of(context),
            responseScalesRepository: RepositoryProvider.of(context),
            sectionsRepository: RepositoryProvider.of(context),
          ),
        ),
      ],
      child: AddEditTemplateWidget(
        templateId: widget.templateId,
        view: widget.view,
      ),
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

  TextEditingController descriptionController = TextEditingController();

  static String pageLabel = 'template';
  static String addButtonName = 'Add Items';

  @override
  void initState() {
    addEditTemplateBloc = context.read();
    templateDetailBloc = context.read();

    if (widget.templateId != null) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditTemplateBloc, AddEditTemplateState>(
      listener: (context, addEditTemplateState) {
        CustomNotification(
          context: context,
          notifyType: NotifyType.success,
          content: addEditTemplateState.message,
        ).showNotification();
        if (widget.templateId == null) {
          GoRouter.of(context).go(
              '/templates/edit/${widget.templateId ?? addEditTemplateState.createdTemplateId}?view=created');
        }
      },
      listenWhen: (previous, current) =>
          previous.templateAddEditStatus != current.templateAddEditStatus &&
          current.templateAddEditStatus.isSuccess,
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
                }
              },
              listenWhen: (previous, current) =>
                  previous.template != current.template &&
                  previous.template == null,
              child: AddEditEntityTemplate(
                label: pageLabel,
                id: widget.templateId,
                selectedEntity: templateDetailState.template,
                addButtonName: addButtonName,
                addEntity: () => addEditTemplateBloc
                    .add(const AddEditTemplateTemplateAddEdited()),
                editEntity: () => addEditTemplateBloc.add(
                    AddEditTemplateTemplateAddEdited(
                        templateId: widget.templateId)),
                crudStatus: addEditTemplateState.templateAddEditStatus,
                isCrudDataFill: _checkFormDataFill(addEditTemplateState),
                tabItems: _buildTabs(),
                tabWidth: 500,
                view: widget.view,
                child: BlocListener<AddEditTemplateBloc, AddEditTemplateState>(
                  listener: (context, state) {
                    context.read<FormDirtyBloc>().add(FormDirtyChanged(
                        isDirty: _checkFormDataFill(addEditTemplateState)));
                  },
                  child:
                      AddEditTemplateDetailsView(templateId: widget.templateId),
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
        : false;
  }

  Map<String, Widget> _buildTabs() {
    if (widget.templateId != null) {
      return {
        'Template Items': TemplateItemsView(templateId: widget.templateId!),
      };
    }
    return {};
  }
}
