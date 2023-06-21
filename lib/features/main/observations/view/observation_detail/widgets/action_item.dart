// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/common_libraries.dart';

class ActionItemView extends StatelessWidget {
  final String actionItem;
  final String status;
  final String due;
  final String assignedBy;
  const ActionItemView({
    Key? key,
    required this.actionItem,
    required this.status,
    required this.due,
    required this.assignedBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBottomBorderContainer(
          padding: insetx20y10,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  actionItem,
                  style: textNormal12,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.regular.appWindow,
                    color: purpleColor,
                    size: 14,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.regular.wrench,
                    color: warnColor,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomBottomBorderContainer(
          color: status == 'Open' ? lightRedAccent : lightGreenAccent,
          padding: insetx20y10,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Status: $status',
                  style: textNormal10,
                ),
              ),
              Expanded(
                child: Text(
                  'Due: $due',
                  style: textNormal10,
                ),
              ),
              Expanded(
                child: Text(
                  'Assigned: $assignedBy',
                  style: textNormal10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
