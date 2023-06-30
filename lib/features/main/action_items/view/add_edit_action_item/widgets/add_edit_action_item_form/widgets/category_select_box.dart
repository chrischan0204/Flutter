import '/common_libraries.dart';

class CategorySelectField extends StatelessWidget {
  const CategorySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditActionItemBloc, AddEditActionItemState>(
      builder: (context, state) {
        Map<String, AwarenessCategory> items = {}..addEntries(state
            .awarenessCategoryList
            .map((category) => MapEntry(category.name ?? '', category)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Observation Category',
          selectedValue:
              state.awarenessCategoryList.isEmpty ? null : state.category?.name,
          onChanged: (category) {
            context
                .read<AddEditActionItemBloc>()
                .add(AddEditActionItemCategoryChanged(category: category.value));
          },
        );
      },
    );
  }
}
