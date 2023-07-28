import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:safety_eta/common_libraries.dart';

showImageDialog({
  required String fileName,
  required String url,
}) {
  return SmartDialog.show(
    builder: (context) {
      return Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: inset30,
                child: Text(
                  fileName,
                  style: textNormal14,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: grey),
                      top: BorderSide(color: grey),
                    ),
                  ),
                  padding: inset20,
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: url,
                    placeholder: (context, url) =>
                        const Center(child: Loader(size: 70)),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 70,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: inset30,
                child: ElevatedButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                  child: Text(
                    'Close',
                    style: textNormal14.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
