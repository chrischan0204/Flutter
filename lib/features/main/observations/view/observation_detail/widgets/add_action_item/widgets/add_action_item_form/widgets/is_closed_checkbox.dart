import '../../../../form_item.dart';
import '/common_libraries.dart';

class IsClosedCheckBox extends StatelessWidget {
  const IsClosedCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddActionItemBloc, AddActionItemState>(
      builder: (context, state) {
        return ObservationDetailFormItemView(
          label: 'Mark as closed',
          content: Container(
            alignment: Alignment.centerLeft,
            child: Tooltip(
              message: 'Mark as closed',
              child: Checkbox(
                value: state.isClosed,
                onChanged: (markAsClosed) =>
                    context.read<AddActionItemBloc>().add(
                          AddActionItemIsClosedChanged(isClosed: markAsClosed!),
                        ),
              ),
            ),
          ),
        );
      },
    );
  }
}
