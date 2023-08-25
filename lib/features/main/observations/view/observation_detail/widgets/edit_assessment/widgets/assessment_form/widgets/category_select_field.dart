import '/common_libraries.dart';
import '../../../../form_item.dart';

class CategorySelectField extends StatelessWidget {
  const CategorySelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Category (*)',
      content: BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
        builder: (context, observationDetailState) {
          Map<String, AwarenessCategory> items = {}..addEntries(
              observationDetailState.awarenessCategoryList
                  .map((category) => MapEntry(category.name ?? '', category)));
          return BlocBuilder<EditAssessmentBloc, EditAssessmentState>(
            builder: (context, editAssessmentState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSingleSelect(
                    items: items,
                    hint: 'Select Awareness Category',
                    selectedValue:
                        observationDetailState.awarenessCategoryList.isEmpty
                            ? null
                            : editAssessmentState.category?.name,
                    onChanged: (category) {
                      context.read<EditAssessmentBloc>().add(
                          EditAssessmentCategoryChanged(
                              category: category.value));
                    },
                  ),
                  if (editAssessmentState
                      .awarenessCategoryValidationMessage.isNotEmpty)
                    Padding(
                      padding: inset4,
                      child: Text(
                        editAssessmentState.awarenessCategoryValidationMessage,
                        style: const TextStyle(fontSize: 12, color: Colors.red),
                      ),
                    )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
