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
                  formDirtyBloc: context.read(),
                )),
        BlocProvider(
            create: (context) => TemplateDetailBloc(
                templatesRepository: RepositoryProvider.of(context))),
        BlocProvider(
          create: (context) => TemplateDesignerBloc(context: context),
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

  static String pageLabel = 'template';
  static String addButtonName = 'Add Items';

  static String editButtonName = 'Update template';

  Map<String, Widget> get tabViews => widget.templateId != null
      ? {
          'Template Items': TemplateItemsView(templateId: widget.templateId!),
        }
      : {};

  @override
  void initState() {
    addEditTemplateBloc = context.read();

    if (widget.templateId != null) {
      addEditTemplateBloc
          .add(AddEditTemplateLoaded(templateId: widget.templateId!));
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.templateId != null) {
      context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
            collapsedItem: 'templates/edit',
            force: true,
          ));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditTemplateBloc, AddEditTemplateState>(
      listener: (context, addEditTemplateState) {
        if (addEditTemplateState.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: addEditTemplateState.message,
          ).showNotification();
          if (widget.templateId == null) {
            GoRouter.of(context).go(
                '/templates/edit/${widget.templateId ?? addEditTemplateState.createdTemplateId}?view=created');
          }
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.templateId,
          selectedEntity: state.loadedTemplate,
          addButtonName: addButtonName,
          addEntity: () =>
              addEditTemplateBloc.add(const AddEditTemplateTemplateAddEdited()),
          editEntity: () => addEditTemplateBloc.add(
              AddEditTemplateTemplateAddEdited(templateId: widget.templateId)),
          crudStatus: state.status,
          formDirty: state.formDirty,
          editButtonName: editButtonName,
          tabItems: tabViews,
          tabWidth: 500,
          view: widget.view,
          child: BlocListener<AddEditTemplateBloc, AddEditTemplateState>(
            listener: (context, state) {},
            child: AddEditTemplateDetailsView(templateId: widget.templateId),
          ),
        );
      },
    );
  }
}
