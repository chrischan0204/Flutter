import '/common_libraries.dart';

class ObservationTypeSelectField extends StatelessWidget {
  const ObservationTypeSelectField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        Map<String, ObservationType> items = {}..addEntries(
            state.observationTypeList.map((observationType) =>
                MapEntry(observationType.name ?? '', observationType)));
        return CustomSingleSelect(
          items: items,
          hint: 'Select Observation Type',
          selectedValue: state.observationTypeList.isEmpty
              ? null
              : state.observationType?.name,
          onChanged: (observationType) {
            context.read<AddEditObservationBloc>().add(
                AddEditObservationObservationTypeChanged(
                    observationType: observationType.value));
          },
        );
      },
    );
  }
}
