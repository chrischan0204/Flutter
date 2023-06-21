import 'package:flutter/foundation.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '/common_libraries.dart';

class MultiImagePicker extends StatefulWidget {
  const MultiImagePicker({super.key});

  @override
  State<MultiImagePicker> createState() => _MultiImagePickerState();
}

class _MultiImagePickerState extends State<MultiImagePicker> {
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
        List<Uint8List>? _imgs = await ImagePickerWeb.getMultiImagesAsBytes();
        setState(() {
          selectedImageCount = (_imgs ?? []).length;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: grey),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                // height: 36,
                color: lightTeal,
                padding: inset10,
                child: Text(
                  'Choose File',
                  style: textNormal14.copyWith(color: Colors.black),
                ),
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
