import '../../../../form_item.dart';
import '/common_libraries.dart';

class CategorySelectField extends StatelessWidget {
  const CategorySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Category',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, AwarenessCategory> items = {}..addEntries(observationDetailState
              .awarenessCategoryList
              .map((category) => MapEntry(category.name ?? '', category)));
          return BlocBuilder<AddActionItemBloc, AddActionItemState>(
            builder: (context, addActionItemState) {
              return CustomSingleSelect(
                items: items,
                hint: 'Select Observation Category',
                selectedValue:
                    observationDetailState.awarenessCategoryList.isEmpty
                        ? null
                        : addActionItemState.category?.name,
                onChanged: (category) {
                  context.read<AddActionItemBloc>().add(
                      AddActionItemCategoryChanged(category: category.value));
                },
              );
            },
          );
        },
      ),
    );
  }
}
