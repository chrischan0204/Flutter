import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import '/common_libraries.dart';

class CustomMultiFilePicker extends StatefulWidget {
  final ValueChanged<List<PlatformFile>> onSelect;
  const CustomMultiFilePicker({
    super.key,
    required this.onSelect,
  });

  @override
  State<CustomMultiFilePicker> createState() => _CustomMultiImagePickerState();
}

class _CustomMultiImagePickerState extends State<CustomMultiFilePicker> {
  int selectedImageCount = 0;

  String _getFilePaths() {
    if (selectedImageCount == 0) {
      return 'No file choosen';
    } else if (selectedImageCount == 1) {
      return '1 file selected';
    } else {
      return '$selectedImageCount files selected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'png', 'doc'],
          );
          setState(() {
            selectedImageCount = (result?.files ?? []).length;
          });

          widget.onSelect(result?.files ?? []);
        } catch (e) {}
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: grey),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  color: lightTeal,
                  padding: inset10,
                  alignment: Alignment.center,
                  child: Text(
                    'Choose File',
                    style: textNormal14.copyWith(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  padding: inset10,
                  child: Text(
                    _getFilePaths(),
                    style: textNormal14.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
