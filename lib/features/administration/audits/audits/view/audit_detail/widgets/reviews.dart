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
                          Container(
                            alignment: Alignment.centerRight,
                            child: CustomButton(
                              onClick: () => context
                                  .read<AuditDetailBloc>()
                                  .add(AuditDetailCommentSaved()),
                              backgroundColor: successColor,
                              hoverBackgroundColor: successHoverColor,
                              body: state.auditReviewCommentSaveStatus.isLoading
                                  ? LoadingAnimationWidget.prograssiveDots(
                                      color: Colors.white,
                                      size: 22,
                                    )
                                  : Text(
                                      'Save',
                                      style: textNormal14.copyWith(
                                          color: Colors.white),
                                    ),
                            ),
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
                        for (final review in state.auditReviewList
                            .where((element) => element.reviewComments != null))
                          ReviewItemView(
                            review: review.reviewComments ?? '',
                            reviewer: review.reviewerName ?? '',
                          ),
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
                      for (final review in state.auditReviewList)
                        ReviewItemView(
                          review: review.reviewComments ?? '',
                          reviewer: review.reviewerName ?? '',
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
  const ReviewItemView({
    super.key,
    required this.review,
    required this.reviewer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insetx20y10,
      child: Row(
        children: [
          Expanded(child: Text(review)),
          Expanded(child: Text('- $reviewer')),
        ],
      ),
    );
  }
}
