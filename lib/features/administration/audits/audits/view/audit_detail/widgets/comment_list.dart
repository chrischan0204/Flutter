import 'package:intl/intl.dart';

import '/common_libraries.dart';

class AuditDetailCommentListView extends StatelessWidget {
  final List<AuditComment> commentList;
  const AuditDetailCommentListView({
    super.key,
    required this.commentList,
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
                    'Comments List',
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
            if (commentList.isNotEmpty)
              Column(
                children: [
                  const AuditDetailCommentListItemView(
                    title: 'Comment',
                    content: 'Added On',
                    isBold: true,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (final comment in commentList)
                            AuditDetailCommentListItemView(
                              title: comment.commentText ?? '--',
                              content: DateFormat('MM/dd/yyyy')
                                  .format(comment.createdOn),
                            )
                        ],
                      ),
                    ),
                  )
                ],
              )
            else
              Padding(
                padding: insety20,
                child: Center(
                  child: Text(
                    'There are no comments.',
                    style: textNormal16,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class AuditDetailCommentListItemView extends StatelessWidget {
  final String title;
  final String content;
  final bool isBold;
  const AuditDetailCommentListItemView({
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
