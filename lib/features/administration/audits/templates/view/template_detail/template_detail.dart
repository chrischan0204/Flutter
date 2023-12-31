import '/common_libraries.dart';
import 'widgets/widgets.dart';

class TemplateDetailView extends StatefulWidget {
  final String templateId;
  const TemplateDetailView({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDetailView> createState() => _TemplateDetailViewState();
}

class _TemplateDetailViewState extends State<TemplateDetailView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TemplateDetailBloc(
                context: context, templateId: widget.templateId)),
      ],
      child: TemplateDetailWidget(templateId: widget.templateId),
    );
  }
}

class TemplateDetailWidget extends StatefulWidget {
  final String templateId;
  const TemplateDetailWidget({
    super.key,
    required this.templateId,
  });

  @override
  State<TemplateDetailWidget> createState() => _TemplateDetailWidgetState();
}

class _TemplateDetailWidgetState extends State<TemplateDetailWidget> {
  late TemplateDetailBloc templatesBloc;

  static String pageTitle = 'Template';
  static String pageLabel = 'template';
  static String descriptionForDelete =
      'This item can not be deleted as it has sites assigned to it.';

  @override
  void initState() {
    templatesBloc = context.read<TemplateDetailBloc>()
      ..add(TemplateDetailTemplateLoadedById(templateId: widget.templateId))
      ..add(TemplateDetailSnapshotLoaded())
      ..add(TemplateDetailAuditTemplateSnapshotLoaded())
      ..add(TemplateDetailSectionListLoaded())
      ..add(TemplateDetailTemplateQuestionDetailLoaded(
        id: widget.templateId,
        itemType: 1,
        level: 0,
      ))
      ..add(TemplateDetailUsageSummaryLoaded());

    context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
          collapsedItem: 'templates/show',
          force: true,
        ));

    super.initState();
  }



  void _deleteTemplate(TemplateDetailState state) {
    templatesBloc
        .add(TemplateDetailTemplateDeleted(templateId: widget.templateId));
  }

  void _checkDeleteTemplateStatus(
      TemplateDetailState state, BuildContext context) {
    if (state.templateDeleteStatus.isSuccess) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();

      GoRouter.of(context).go('/templates');
    }
    if (state.templateDeleteStatus.isFailure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: state.message,
      ).showNotification();
    }
  }

  Widget _buildCustomDetailWidget() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TemplateView(),
          QuestionsView(templateId: widget.templateId),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TemplateDetailBloc, TemplateDetailState>(
      listener: (context, state) => _checkDeleteTemplateStatus(state, context),
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => _deleteTemplate(state),
          customDetailWidget: _buildCustomDetailWidget(),
          entity: state.template,
          isShowName: false,
          crudStatus: state.templateDeleteStatus,
          descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
