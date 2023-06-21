import '/common_libraries.dart';

class ResponseTextField extends StatelessWidget {
  const ResponseTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditObservationBloc, AddEditObservationState>(
      builder: (context, state) {
        return CustomTextField(
          key: ValueKey(state.loadedObservation?.id),
          initialValue: state.response,
          hintText: 'What did you do? e.g. called housekeeping to address isssue',
          onChanged: (response) {
            context
                .read<AddEditObservationBloc>()
                .add(AddEditObservationResponseChanged(response: response));
          },
        );
      },
    );
  }
}
