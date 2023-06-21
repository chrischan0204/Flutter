import '/common_libraries.dart';
import 'action_item.dart';

class AddActionItemView extends StatelessWidget {
  const AddActionItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            color: lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Action Item',
                  style: textNormal14,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: Text(
                    'Add Action Item',
                    style: textNormal12.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ActionItemView(
            actionItem: 'Inspect the staircase on an ASAP basis.',
            status: 'Open',
            due: '21st May 2023',
            assignedBy: 'Carl Gurman',
          ),
          ActionItemView(
            actionItem: 'Assign a cleaning crew to address this',
            status: 'Closed',
            due: '21st May 2023',
            assignedBy: 'Oscar Bailey',
          ),
        ],
      ),
    );
  }
}
