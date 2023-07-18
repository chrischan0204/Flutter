import '/common_libraries.dart';

class DockImageUploadView extends StatelessWidget {
  const DockImageUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomBottomBorderContainer(
          padding: inset20,
          child: Text(
            'Upload Images',
            style: textNormal18,
          ),
        ),
        Padding(
          padding: inset20,
          child: CustomMultiFilePicker(
            onSelect: (imageList) => context
                .read<ObservationImageDockBloc>()
                .add(ObservatioinImageDockFileListChanged(fileList: imageList)),
          ),
        ),
      ],
    );
  }
}
