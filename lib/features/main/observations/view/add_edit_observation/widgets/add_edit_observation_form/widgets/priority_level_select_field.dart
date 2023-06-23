import '/common_libraries.dart';

class PriorityLevelSelectField extends StatelessWidget {
  const PriorityLevelSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        Map<String, PriorityLevel> items = {}..addEntries(
            state.priorityLevelList.map((priorityLevel) =>
                MapEntry(priorityLevel.name ?? '', priorityLevel)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Priority Level',
          selectedValue: state.priorityLevelList.isEmpty
              ? null
              : state.priorityLevel?.name,
          onChanged: (priorityLevel) {
            context.read<AddEditObservationBloc>().add(
                AddEditObservationPriorityLevelChanged(
                    priorityLevel: priorityLevel.value));
          },
        );
      },
    );
  }
}
