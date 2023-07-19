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
        .map((item) => Container(
              margin: inset4,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  'https://api.allorigins.win/raw?url=${item.uri ?? ''}',
                  fit: BoxFit.fitWidth,
                  width: 1000.0,
                ),
              ),
            ))
        .toList();
    return AlertDialog(
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBottomBorderContainer(
              padding: inset20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Images',
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: IconButton(
                            onPressed: () => _controller.previousPage(),
                            icon: Icon(
                              PhosphorIcons.regular.arrowArcLeft,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        ...Iterable<int>.generate(widget.imageList.length).map(
                          (int pageIndex) => Flexible(
                            child: InkWell(
                              onTap: () => _controller.animateToPage(pageIndex),
                              child: Image.network(
                                  widget.imageList
                                      .map((e) =>
                                          'https://api.allorigins.win/raw?url=${e.uri ?? ''}')
                                      .toList()[pageIndex],
                                  fit: BoxFit.fitHeight,
                                  height: 50.0),
                            ),
                          ),
                        ),
                        Flexible(
                          child: IconButton(
                            onPressed: () => _controller.nextPage(),
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
                    options: CarouselOptions(enlargeCenterPage: true),
                    carouselController: _controller,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
