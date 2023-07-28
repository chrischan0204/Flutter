import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '/common_libraries.dart';

class AuditDetailImageListView extends StatefulWidget {
  final List<Document> imageList;
  const AuditDetailImageListView({
    super.key,
    required this.imageList,
  });

  @override
  State<AuditDetailImageListView> createState() =>
      _AuditDetailImageListViewState();
}

class _AuditDetailImageListViewState extends State<AuditDetailImageListView> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imageList
        .where((element) => element.documentType!.isImage)
        .map((item) => Container(
              margin: inset4,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  imageUrl: item.uri ?? '',
                  placeholder: (context, url) =>
                      const Center(child: Loader(size: 70)),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 70,
                  ),
                  fit: BoxFit.fitWidth,
                  width: 1000.0,
                ),
              ),
            ))
        .toList();

    final documentList = widget.imageList
        .where((element) => !element.documentType!.isImage)
        .toList();
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width / 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBottomBorderContainer(
                padding: inset20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Images/Documents',
                      style: textSemiBold18,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        PhosphorIcons.regular.x,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: insety20,
                child: CustomTabBar(
                    activeIndex: 0,
                    tabs: {
                      'Images': Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: inset10,
                            child: Text(
                              'These images were uploaded in this audit...',
                              style: textSemiBold18,
                            ),
                          ),
                          Padding(
                            padding: inset10,
                            child: Column(
                              children: <Widget>[
                                CustomBottomBorderContainer(
                                  padding: inset10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: IconButton(
                                          onPressed: () =>
                                              _controller.previousPage(),
                                          icon: Icon(
                                            PhosphorIcons.regular.arrowArcLeft,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      ...Iterable<int>.generate(
                                              widget.imageList.length)
                                          .map(
                                        (int pageIndex) => Flexible(
                                          child: InkWell(
                                            onTap: () => _controller
                                                .animateToPage(pageIndex),
                                            child: CachedNetworkImage(
                                              imageUrl: widget.imageList
                                                  .where((element) => element
                                                      .documentType!.isImage)
                                                  .map((e) => e.uri ?? '')
                                                  .toList()[pageIndex],
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child: Loader(size: 30)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                size: 30,
                                              ),
                                              fit: BoxFit.fitHeight,
                                              height: 50.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: IconButton(
                                          onPressed: () =>
                                              _controller.nextPage(),
                                          icon: Icon(
                                            PhosphorIcons.regular.arrowArcRight,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CarouselSlider(
                                  items: imageSliders,
                                  options:
                                      CarouselOptions(enlargeCenterPage: true),
                                  carouselController: _controller,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      'Documents': Column(
                        children: [
                          for (final document in documentList)
                            DocumentListItemView(document: document)
                        ],
                      ),
                    },
                    onTabClick: (_) async {
                      return true;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentListItemView extends StatelessWidget {
  final Document document;
  const DocumentListItemView({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: insetx24y12,
      child: Row(
        children: [
          Expanded(
            child: Text(
              document.originalFileName ?? '',
              style: textNormal14,
            ),
          ),
          IconButton(
            onPressed: () async {
              await downloadFile(document.uri ?? '',
                  filename: document.originalFileName ?? '',
                  ext: document.documentType!.split('.').last);
            },
            icon: Icon(
              PhosphorIcons.regular.downloadSimple,
              color: purpleColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
