import '../../../../form_item.dart';
import '/common_libraries.dart';

class ActionItemImagePicker extends StatelessWidget {
  const ActionItemImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ObservationDetailFormItemView(
      label: 'Images',
      content: CustomMultiFilePicker(
        onSelect: (imageList) => context
            .read<AddActionItemBloc>()
            .add(AddActionItemImageListChanged(imageList: imageList)),
      ),
    );
  }
}
