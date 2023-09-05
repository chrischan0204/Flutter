import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../../common_libraries.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          return BlocConsumer<AuditDetailBloc, AuditDetailState>(
            listener: (context, state) => CustomNotification(
              context: context,
              notifyType: NotifyType.success,
              content: state.message,
            ).showNotification(),
            listenWhen: (previous, current) =>
                previous.auditReviewCommentSaveStatus !=
                    current.auditReviewCommentSaveStatus &&
                current.auditReviewCommentSaveStatus.isSuccess,
            builder: (context, state) {
              if (state.auditReviewList.isNotEmpty) {
                if (state.auditReviewList.length == 1) {
                  if (state.auditReviewList[0].reviewerId == authState.userId) {
                    return Padding(
                      padding: inset10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Leave Comment',
                            style: textSemiBold18,
                          ),
                          spacery12,
                          CustomTextField(
                            key: ValueKey(state.auditReviewList[0].id),
                            isDisabled: !state.isCommentEditing,
                            initialValue:
                                state.auditReviewList[0].reviewComments,
                            contentPadding: inset10,
                            onChanged: (value) => context
                                .read<AuditDetailBloc>()
                                .add(AuditDetailCommentChanged(comment: value)),
                            maxLines: 100,
                            minLines: 3,
                            height: null,
                          ),
                          spacery10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (!state.isCommentEditing)
                                Padding(
                                  padding: insetx20,
                                  child: Text(
                                      'Reviewed on ${state.auditReviewList[0].formatedReviewDate}'),
                                )
                              else
                                const Spacer(),
                              Row(
                                children: [
                                  CustomButton(
                                    onClick: () {
                                      if (state.isCommentEditing) {
                                        context
                                            .read<AuditDetailBloc>()
                                            .add(AuditDetailCommentSaved());
                                      } else {
                                        context.read<AuditDetailBloc>().add(
                                            AuditDetailIsEditingCommentChanged(
                                                isCommentEditing:
                                                    !state.isCommentEditing));
                                      }
                                    },
                                    backgroundColor: successColor,
                                    hoverBackgroundColor: successHoverColor,
                                    body: state.auditReviewCommentSaveStatus
                                            .isLoading
                                        ? LoadingAnimationWidget
                                            .prograssiveDots(
                                            color: Colors.white,
                                            size: 22,
                                          )
                                        : state.isCommentEditing
                                            ? Text(
                                                'Save',
                                                style: textNormal14.copyWith(
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                'Edit',
                                                style: textNormal14.copyWith(
                                                    color: Colors.white),
                                              ),
                                  ),
                                  if (state.isCommentEditing) spacerx20,
                                  if (state.isCommentEditing)
                                    CustomButton(
                                      onClick: () => context
                                          .read<AuditDetailBloc>()
                                          .add(
                                              const AuditDetailIsEditingCommentChanged(
                                                  isCommentEditing: false)),
                                      backgroundColor: Colors.grey,
                                      hoverBackgroundColor: Colors.grey,
                                      body: Text(
                                        'Cancel',
                                        style: textNormal14.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomBottomBorderContainer(
                          padding: insetx10y20,
                          child: Text(
                            'Reviews',
                            style: textSemiBold16,
                          ),
                        ),
                        const ReviewItemView(
                          review: 'Comments',
                          reviewer: 'Reviewer',
                          reviewedOn: 'Reviewed On',
                          isTitle: true,
                        ),
                        if (state.auditReviewList.isNotEmpty)
                          for (final review in state.auditReviewList)
                            ReviewItemView(
                              review:
                                  review.reviewComments ?? 'Not Reviewed Yet',
                              reviewer: review.reviewerName ?? '',
                              reviewedOn: review.formatedReviewDate,
                            )
                        else
                          Center(
                            child: Padding(
                              padding: inset20,
                              child: const Text(
                                  'There is no review yet on this audit.'),
                            ),
                          )
                      ],
                    );
                  }
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomBottomBorderContainer(
                        padding: insetx10y20,
                        child: Text(
                          'Reviews',
                          style: textSemiBold16,
                        ),
                      ),
                      const ReviewItemView(
                        review: 'Comments',
                        reviewer: 'Reviewer',
                        reviewedOn: 'Reviewed On',
                        isTitle: true,
                      ),
                      for (final review in state.auditReviewList)
                        ReviewItemView(
                          review: review.reviewComments ?? 'Not Reviewed Yet',
                          reviewer: review.reviewerName ?? '',
                          reviewedOn: review.formatedReviewDate,
                        ),
                    ],
                  );
                }
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}

class ReviewItemView extends StatelessWidget {
  final String review;
  final String reviewer;
  final String reviewedOn;
  final bool isTitle;
  const ReviewItemView({
    super.key,
    required this.review,
    required this.reviewer,
    required this.reviewedOn,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx20y10,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              review,
              style: isTitle ? textSemiBold14 : null,
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                reviewer,
                style: isTitle ? textSemiBold14 : null,
              )),
          Expanded(
              flex: 1,
              child: Text(
                reviewedOn,
                style: isTitle ? textSemiBold14 : null,
              )),
        ],
      ),
    );
  }
}
