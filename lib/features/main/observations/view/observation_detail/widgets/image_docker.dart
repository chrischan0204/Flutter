import 'package:carousel_slider/carousel_slider.dart';
import '/common_libraries.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ImageDockerView extends StatefulWidget {
  const ImageDockerView({super.key});

  @override
  State<ImageDockerView> createState() => _ImageDockerViewState();
}

class _ImageDockerViewState extends State<ImageDockerView> {
  final CarouselController _controller = CarouselController();

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: inset4,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(item, fit: BoxFit.fitWidth, width: 1000.0),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            backgroundColor: lightBlueAccent,
            padding: inset20,
            child: Text(
              'Image Dock',
              style: textSemiBold14,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
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
                        ...Iterable<int>.generate(imgList.length).map(
                          (int pageIndex) => Flexible(
                            child: InkWell(
                              onTap: () => _controller.animateToPage(pageIndex),
                              child: Image.network(imgList[pageIndex],
                                  fit: BoxFit.fitHeight, height: 50.0),
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
            ),
          ),
        ],
      ),
    );
  }
}
