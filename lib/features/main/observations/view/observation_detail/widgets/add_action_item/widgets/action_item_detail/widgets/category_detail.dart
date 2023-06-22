import '/common_libraries.dart';
import '../../../../form_item.dart';

class CategoryDetailView extends StatelessWidget {
  const CategoryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Category',
      content: BlocBuilder<AddActionItemBloc, AddActionItemState>(
        builder: (context, state) {
          return Text(
            state.actionItem!.category,
            style: textNormal14,
          );
        },
      ),
    );
  }
}
