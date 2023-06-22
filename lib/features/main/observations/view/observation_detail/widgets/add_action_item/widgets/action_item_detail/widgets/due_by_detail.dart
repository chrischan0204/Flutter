import '/common_libraries.dart';
import '../../../../form_item.dart';

class DueByDetailView extends StatelessWidget {
  const DueByDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Due',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.formatedDue,
            style: textNormal14,
          );
        },
      ),
    );
  }
}
