import '/common_libraries.dart';

class ObservationImagePicker extends StatelessWidget {
  const ObservationImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMultiFilePicker(
      onSelect: (imageList) => context
          .read<AddEditObservationBloc>()
          .add(AddEditObservationImageListChanged(imageList: imageList)),
    );
  }
}
