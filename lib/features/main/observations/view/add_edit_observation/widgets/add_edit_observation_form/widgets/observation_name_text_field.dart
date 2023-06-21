import '/common_libraries.dart';

class ObservationNameTextField extends StatelessWidget {
  const ObservationNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedObservation?.id),
          initialValue: state.observationName,
          hintText: 'Safety Observation. e.g. Slippery staircase due to oil spill.',
          onChanged: (observationName) {
            context
                .read<AddEditObservationBloc>()
                .add(AddEditObservationNameChanged(observationName: observationName));
          },
        );
      },
    );
  }
}
