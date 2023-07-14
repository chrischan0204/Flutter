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
      return '1 image selected';
    } else {
      return '$selectedImageCount images selected';
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
        } catch (e) {
          print(e);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: grey),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              color: lightTeal,
              padding: inset10,
              child: Text(
                'Choose File',
                style: textNormal14.copyWith(color: Colors.black),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                // height: 36,
                padding: inset10,
                child: Text(
                  _getFilePaths(),
                  style: textNormal14.copyWith(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
