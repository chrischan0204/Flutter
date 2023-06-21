import '/common_libraries.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedObservation?.id),
          initialValue: state.location,
          hintText: 'Observation location e.g. in front of admin office',
          onChanged: (location) {
            context
                .read<AddEditObservationBloc>()
                .add(AddEditObservationLocationChanged(location: location));
          },
        );
      },
    );
  }
}
