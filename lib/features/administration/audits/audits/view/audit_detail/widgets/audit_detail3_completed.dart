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
    context.read<AuditDetailBloc>().add(AuditDetailReviewerListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<AuditDetailBloc, AuditDetailState>(
        builder: (context, state) {
          final audit = state.auditSummary!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuditDetailItemView(
                label: 'Status',
                content: audit.area ?? '--',
              ),
              if (state.selectedMethod == 'Close Audit')
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
                          width: MediaQuery.of(context).size.width / 4,
                          title: 'Confirm',
                          description:
                              'Are you sure you want to close the audit?',
                          btnOkText: 'OK',
                          btnCancelOnPress: () {},
                          btnOkOnPress: () => context
                              .read<AuditDetailBloc>()
                              .add(AuditDetailMethodSelected(
                                  method: value.value)),
                          dialogType: DialogType.question,
                        ).show();
                      } else {
                        context.read<AuditDetailBloc>().add(
                            AuditDetailMethodSelected(method: value.value));
                      }
                    },
                  ),
                ),
              if (state.selectedMethod == 'Send for review')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < state.selectedReviewerList.length; i++)
                      ReviewerItemView(
                        index: i,
                        selectedReviewer: state.selectedReviewerList[i],
                        reviewerList: state.reviewerList,
                      ),
                    Padding(
                      padding: inset10,
                      child: CustomButton(
                        onClick: () {},
                        backgroundColor: successColor,
                        hoverBackgroundColor: successHoverColor,
                        body: Text(
                          'Send for review',
                          style: textNormal14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ],
          );
        },
      ),
    );
  }
}

class ReviewerItemView extends StatelessWidget {
  final int index;
  final User? selectedReviewer;
  final List<User> reviewerList;
  const ReviewerItemView({
    super.key,
    required this.index,
    required this.selectedReviewer,
    required this.reviewerList,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, User> items = {}
      ..addEntries(reviewerList.map((user) => MapEntry(user.name ?? '', user)));
    return CustomBottomBorderContainer(
      padding: inset10,
      child: Row(
        children: [
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
            onPressed: () => context
                .read<AuditDetailBloc>()
                .add(AuditDetailReviewerItemIncreased(index: index)),
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
