import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../../common_libraries.dart';
import '../../widgets/detail_item.dart';

class AuditDetail3CompletedView extends StatefulWidget {
  const AuditDetail3CompletedView({super.key});

  @override
  State<AuditDetail3CompletedView> createState() =>
      _AuditDetail3CompletedViewState();
}

class _AuditDetail3CompletedViewState extends State<AuditDetail3CompletedView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocBuilder<AuditDetailBloc, AuditDetailState>(
            builder: (context, state) {
              final audit = state.auditSummary!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuditDetailItemView(
                    label: 'Status',
                    content: audit.auditStatusName ?? '--',
                  ),
                  if (state.isNextStepsAvailable(authState))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (state.auditSummary?.auditStatusName == 'Closed')
                          CustomBottomBorderContainer(
                            padding: inset10,
                            child: Text(
                              'This audit is closed',
                              style: textSemiBold14.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          )
                        else
                          CustomBottomBorderContainer(
                            padding: inset10,
                            child: Text(
                              'Next Steps',
                              style: textSemiBold14.copyWith(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        if (state.auditSummary?.auditStatusName != 'Closed')
                          if (state.selectedMethod != 'Close Audit')
                            CustomBottomBorderContainer(
                              padding: inset10,
                              child: CustomSingleSelect(
                                hint: 'Please select',
                                items: const {
                                  'Close Audit': 'Close Audit',
                                  'Send for review': 'Send for review',
                                },
                                selectedValue: state.selectedMethod,
                                onChanged: (value) {
                                  if (value.value == 'Close Audit') {
                                    CustomAlert(
                                      context: context,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      title: 'Confirm',
                                      description:
                                          'Are you sure you want to close the audit?',
                                      btnOkText: 'OK',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        context.read<AuditDetailBloc>().add(
                                            AuditDetailMethodSelected(
                                                method: value.value));
                                        context
                                            .read<AuditDetailBloc>()
                                            .add(AuditDetailAuditMarkClosed());
                                      },
                                      dialogType: DialogType.question,
                                    ).show();
                                  } else {
                                    context.read<AuditDetailBloc>().add(
                                        AuditDetailMethodSelected(
                                            method: value.value));
                                  }
                                },
                              ),
                            ),
                        if (state.auditSummary?.auditStatusName != 'Closed')
                          if (state.selectedMethod == 'Send for review')
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < state.selectedReviewerList.length;
                                    i++)
                                  ReviewerItemView(
                                    index: i,
                                    selectedReviewer:
                                        state.selectedReviewerList[i],
                                    reviewerList: state.reviewerList,
                                    canAddReviewer: state.canAddReviewer,
                                  ),
                                if (state.selectedReviewerList.isNotEmpty)
                                  Padding(
                                    padding: inset10,
                                    child: BlocConsumer<AuditDetailBloc,
                                        AuditDetailState>(
                                      listener: (context, state) =>
                                          CustomNotification(
                                        context: context,
                                        notifyType: NotifyType.success,
                                        content:
                                            'Reviewers saved successfully.',
                                      ).showNotification(),
                                      listenWhen: (previous, current) =>
                                          previous.auditReviewersSaveStatus !=
                                              current
                                                  .auditReviewersSaveStatus &&
                                          current.auditReviewersSaveStatus
                                              .isSuccess,
                                      builder: (context, state) {
                                        return CustomButton(
                                          onClick: () {
                                            if (state.selectedReviewerList
                                                .where((element) =>
                                                    element == null)
                                                .isNotEmpty) {
                                              CustomNotification(
                                                context: context,
                                                notifyType: NotifyType.info,
                                                content:
                                                    'Please select reviewers',
                                              ).showNotification();
                                            } else {
                                              context.read<AuditDetailBloc>().add(
                                                  AuditDetailReviewersSaved());
                                            }
                                          },
                                          backgroundColor: successColor,
                                          hoverBackgroundColor:
                                              successHoverColor,
                                          body: state.auditReviewersSaveStatus
                                                  .isLoading
                                              ? LoadingAnimationWidget
                                                  .prograssiveDots(
                                                  color: Colors.white,
                                                  size: 22,
                                                )
                                              : Text(
                                                  'Send for review',
                                                  style: textNormal14.copyWith(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                        if (state.auditSummary?.auditStatusName == 'In Review')
                          if (state.auditReviewList.isNotEmpty)
                            Column(
                              children: [
                                CustomBottomBorderContainer(
                                  padding: inset10,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Reviewer',
                                          style: textSemiBold14,
                                        ),
                                      ),
                                      spacerx10,
                                      Expanded(
                                        child: Text(
                                          'Added On',
                                          style: textSemiBold14,
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 160,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (final reviewer
                                            in state.auditReviewList)
                                          ReviewerListItemView(
                                            reviewer:
                                                reviewer.reviewerName ?? '',
                                            addedOn: reviewer.reviewDate ??
                                                DateTime.now(),
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ],
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class ReviewerListItemView extends StatelessWidget {
  final String reviewer;
  final DateTime addedOn;
  const ReviewerListItemView({
    super.key,
    required this.reviewer,
    required this.addedOn,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset10,
      child: Row(
        children: [
          Expanded(
            child: Text(
              reviewer,
            ),
          ),
          spacerx10,
          Expanded(
              child: Text(
            DateFormat('MM/dd/yyy').format(addedOn),
            textAlign: TextAlign.end,
          ))
        ],
      ),
    );
  }
}

class ReviewerItemView extends StatelessWidget {
  final int index;
  final User? selectedReviewer;
  final List<User> reviewerList;
  final bool canAddReviewer;
  const ReviewerItemView({
    super.key,
    required this.index,
    required this.selectedReviewer,
    required this.reviewerList,
    required this.canAddReviewer,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, User> items = {};
    if (selectedReviewer != null) {
      items.addAll({selectedReviewer!.name!: selectedReviewer!});
    }

    items.addEntries(
        reviewerList.map((user) => MapEntry(user.name ?? '', user)));

    return CustomBottomBorderContainer(
      padding: inset10,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (index > 0) {
                context
                    .read<AuditDetailBloc>()
                    .add(AuditDetailReviewerItemRemoved(index: index));
              } else {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.info,
                  content: 'At least one column is required',
                ).showNotification();
              }
            },
            icon: PhosphorIcon(
              PhosphorIcons.regular.x,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: CustomSingleSelect(
              hint: 'Select Reviewer',
              items: items,
              selectedValue: selectedReviewer?.name,
              onChanged: (reviewer) => context
                  .read<AuditDetailBloc>()
                  .add(AuditDetailReviewerSelected(
                    index: index,
                    reviewer: reviewer.value,
                  )),
            ),
          ),
          IconButton(
            onPressed: () {
              if (canAddReviewer) {
                context
                    .read<AuditDetailBloc>()
                    .add(AuditDetailReviewerItemIncreased(index: index));
              } else {
                CustomNotification(
                  context: context,
                  notifyType: NotifyType.info,
                  content: 'No more reviewer available',
                ).showNotification();
              }
            },
            icon: PhosphorIcon(
              PhosphorIcons.regular.plusCircle,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
