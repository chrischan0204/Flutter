import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ObservationDetailView extends StatelessWidget {
  final String observationId;
  const ObservationDetailView({
    super.key,
    required this.observationId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObservationDetailBloc(context),
      child: ObservationDetailWidget(observationId: observationId),
    );
  }
}

class ObservationDetailWidget extends StatefulWidget {
  final String observationId;
  const ObservationDetailWidget({
    super.key,
    required this.observationId,
  });

  @override
  State<ObservationDetailWidget> createState() => _ObservationDetailViewState();
}

class _ObservationDetailViewState extends State<ObservationDetailWidget> {
  static String pageTitle = 'Observation';
  static String pageLabel = 'Observation';

  @override
  void initState() {
    context.read<ObservationDetailBloc>()
      ..add(ObservationDetailLoaded(observationId: widget.observationId))
      ..add(ObservationDetailObservationCategoryListLoaded())
      ..add(ObservationDetailObservationTypeListLoaded())
      ..add(ObservationDetailPriorityLevelListLoaded())
      ..add(ObservationDetailCompanyListLoaded())
      ..add(ObservationDetailProjectListLoaded())
      ..add(ObservationDetailSiteListLoaded())
      ..add(ObservationDetailUserListLoaded());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ThemeBloc>().add(const ThemeSidebarItemExtended(
          collapsedItem: 'observations/show',
          force: true,
        ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationDetailBloc, ObservationDetailState>(
      listener: (context, state) {
        if (state.observationDeleteStatus.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            content: state.message,
          ).showNotification();

          GoRouter.of(context).go('/observations');
        }
        if (state.observationDeleteStatus.isFailure) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) =>
          previous.observationDeleteStatus != current.observationDeleteStatus,
      builder: (context, state) {
        return EntityShowTemplate(
          title: pageTitle,
          label: pageLabel,
          deleteEntity: () => context.read<ObservationDetailBloc>().add(
              ObservationDetailObservationDeleted(
                  observationId: widget.observationId)),
          entity: state.observation,
          crudStatus: state.observationDeleteStatus,
          isDeletable: false,
          isEditable: false,
          customDetailWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ObservationDetailHeaderView(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        const DetailView(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: BlocProvider(
                                create: (context) => EditAssessmentBloc(
                                    context, widget.observationId),
                                child: const EditAssessmentView(),
                              ),
                            ),
                            spacerx5,
                            Expanded(
                              flex: 2,
                              child: BlocProvider(
                                create: (context) => AddActionItemBloc(context),
                                child: AddActionItemView(
                                    observationId: widget.observationId),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  spacerx10,
                  const Expanded(
                    flex: 2,
                    child: ImageDockerView(),
                  ),
                ],
              ),
            ],
          ),
          // descriptionForDelete: descriptionForDelete,
        );
      },
    );
  }
}
