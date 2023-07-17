import '/common_libraries.dart';
import 'widgets/widgets.dart';

class EditAssessmentView extends StatelessWidget {
  const EditAssessmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AssessmentHeaderView(),
          BlocConsumer<EditAssessmentBloc, EditAssessmentState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.success,
                  content: state.message,
                ).showNotification();
              }
            },
            listenWhen: (previous, current) =>
                previous.status != current.status,
            builder: (context, state) {
              if (state.isEditing) {
                return const AssessmentFormView();
              } else {
                return BlocConsumer<ObservationDetailBloc,
                    ObservationDetailState>(
                  listener: (context, state) {
                    final observation = state.observation!;

                    if (observation.assessmentAwarenessCategoryId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentCategoryChanged(
                              category: AwarenessCategory(
                            id: observation.assessmentAwarenessCategoryId,
                            name: observation.assessmentAwarenessCategoryName,
                          )));
                    }

                    if (observation.assessmentObservationTypeId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentObservationTypeChanged(
                              observationType: ObservationType(
                            id: observation.assessmentObservationTypeId,
                            name: observation.assessmentObservationTypeName,
                            severity: '',
                          )));
                    }

                    if (observation.assessmentPriorityLevelId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentPriorityLevelChanged(
                              priorityLevel: PriorityLevel(
                            id: observation.assessmentPriorityLevelId,
                            name: observation.assessmentPriorityLevelName,
                            colorCode: Colors.white,
                            priorityType: '',
                          )));
                    }

                    if (observation.assessmentCompanyId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentCompanyChanged(
                              company: Company(
                            id: observation.assessmentCompanyId,
                            name: observation.assessmentCompanyName,
                          )));
                    }

                    if (observation.assessmentProjectId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentProjectChanged(
                              project: Project(
                            id: observation.assessmentProjectId,
                            name: observation.assessmentProjectName,
                          )));
                    }

                    if (observation.assessmentSiteId != null) {
                      context
                          .read<EditAssessmentBloc>()
                          .add(EditAssessmentSiteChanged(
                            site: Site(
                              id: observation.assessmentSiteId,
                              name: observation.assessmentSiteName,
                            ),
                            isFirst: true,
                          ));
                    }

                    context.read<EditAssessmentBloc>().add(
                        EditAssessmentFollowUpCloseoutChanged(
                            followUpCloseout:
                                observation.assessmentFollowupComment ?? ''));

                    context.read<EditAssessmentBloc>().add(
                        EditAssessmentMarkAsClosedChanged(
                            markAsClosed: observation.isClosed ?? false));

                    context.read<EditAssessmentBloc>().add(
                        EditAssessmentNotifySenderChanged(
                            notifySender: observation.notificationSent));
                  },
                  listenWhen: (previous, current) =>
                      previous.observation == null &&
                      previous.observation != current.observation,
                  builder: (context, state) {
                    if (state.observation?.assessedOn == null) {
                      return Center(
                        child: Padding(
                          padding: insety20,
                          child: Text(
                            'Not yet assessed',
                            style: textNormal14,
                          ),
                        ),
                      );
                    }
                    return const AssessmentDetailView();
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
