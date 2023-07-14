import 'package:carousel_slider/carousel_slider.dart';
import '/common_libraries.dart';

class ImageDockerView extends StatefulWidget {
  const ImageDockerView({super.key});

  @override
  State<ImageDockerView> createState() => _ImageDockerViewState();
}

class _ImageDockerViewState extends State<ImageDockerView> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    context
        .read<ObservationDetailBloc>()
        .add(ObservationDetailImageListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationDetailBloc, ObservationDetailState>(
      builder: (context, state) {
        final List<Widget> imageSliders = state.imageList
            .map((item) => Container(
                  margin: inset4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(item.uri ?? '',
                        fit: BoxFit.fitWidth, width: 1000.0),
                  ),
                ))
            .toList();
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
                            ...Iterable<int>.generate(state.imageList.length)
                                .map(
                              (int pageIndex) => Flexible(
                                child: InkWell(
                                  onTap: () =>
                                      _controller.animateToPage(pageIndex),
                                  child: Image.network(
                                      state.imageList
                                          .map((e) => e.uri ?? '')
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
