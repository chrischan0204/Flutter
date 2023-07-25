import '/common_libraries.dart';

class IsClosedCheckBox extends StatelessWidget {
  const IsClosedCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Checkbox(
              value: state.isClosed,
              onChanged: (isClosed) => context
                  .read<AddEditActionItemBloc>()
                  .add(AddEditActionItemIsClosedChanged(isClosed: isClosed!))),
        );
      },
    );
  }
}
