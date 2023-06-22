// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/common_libraries.dart';

class ActionItemView extends StatelessWidget {
  final ActionItem actionItem;
  const ActionItemView({
    Key? key,
    required this.actionItem,
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
                  actionItem.task,
                  style: textNormal12,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () => context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemDetailShown(actionItem: actionItem)),
                  icon: Icon(
                    PhosphorIcons.regular.appWindow,
                    color: purpleColor,
                    size: 14,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () => context
                      .read<AddActionItemBloc>()
                      .add(AddActionItemDetailEdited(actionItem: actionItem)),
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
          backgroundColor: actionItem.status.isOpen ? lightRedAccent : lightGreenAccent,
          padding: insetx20y10,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Status: ${actionItem.status.toString()}',
                  style: textNormal10,
                ),
              ),
              Expanded(
                child: Text(
                  'Due: ${actionItem.formatedDue}',
                  style: textNormal10,
                ),
              ),
              Expanded(
                child: Text(
                  'Assigned: ${actionItem.assignee}',
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
