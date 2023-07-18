import 'package:carousel_slider/carousel_slider.dart';
import '/common_libraries.dart';

class DockImageListView extends StatefulWidget {
  const DockImageListView({super.key});

  @override
  State<DockImageListView> createState() => _DockImageListViewState();
}

class _DockImageListViewState extends State<DockImageListView> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    context
        .read<ObservationImageDockBloc>()
        .add(ObservationImageDockImageListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObservationImageDockBloc, ObservationImageDockState>(
      builder: (context, state) {
        if (state.imageListLoadStatus.isLoading) {
          return const Center(child: Loader());
        }

        final List<Widget> imageSliders = state.imageList
            .map((item) => Container(
                  margin: inset4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                        'https://api.allorigins.win/raw?url=${item.uri ?? ''}',
                        fit: BoxFit.fitWidth,
                        width: 1000.0),
                  ),
                ))
            .toList();
        return SingleChildScrollView(
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
                      ...Iterable<int>.generate(state.imageList.length).map(
                        (int pageIndex) => Flexible(
                          child: InkWell(
                            onTap: () => _controller.animateToPage(pageIndex),
                            child: Image.network(
                                state.imageList
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
          ),
        );
      },
    );
  }
}
