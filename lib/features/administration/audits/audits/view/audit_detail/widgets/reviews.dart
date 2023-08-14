import '../../../../../../../common_libraries.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: insetx10y20,
            child: Text(
              'Reviews',
              style: textSemiBold16,
            ),
          ),
          ReviewItemView(
            review:
                'Reviewed this audit and it seems to be correct and executed well.',
            reviewer: 'Andy White',
          ),
          ReviewItemView(
            review: 'Checked and Reviewed. The answers seem satisfactory.',
            reviewer: 'Grace Beck',
          ),
        ],
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
