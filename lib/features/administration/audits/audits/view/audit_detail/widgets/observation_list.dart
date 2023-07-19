import '/common_libraries.dart';

class AuditDetailObservationListView extends StatelessWidget {
  final List<ObservationDetail> observationList;
  const AuditDetailObservationListView({
    super.key,
    required this.observationList,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBottomBorderContainer(
              padding: inset20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Observations List',
                    style: textSemiBold18,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      PhosphorIcons.regular.x,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: inset10,
              child: Text(
                'The following observation were created in this audit...',
                style: textSemiBold18,
              ),
            ),
            const AuditDetailObservationListItemView(
              title: 'Observation',
              content: 'Area',
              isBold: true,
            ),
            for (final observation in observationList)
              AuditDetailObservationListItemView(
                title: observation.description ?? '--',
                content: observation.area ?? '--',
              )
          ],
        ),
      ),
    );
  }
}

class AuditDetailObservationListItemView extends StatelessWidget {
  final String title;
  final String content;
  final bool isBold;
  const AuditDetailObservationListItemView({
    super.key,
    required this.title,
    required this.content,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx24y12,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: isBold ? textBold14 : textSemiBold14,
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: isBold ? textBold14 : textSemiBold14,
            ),
          ),
        ],
      ),
    );
  }
}
