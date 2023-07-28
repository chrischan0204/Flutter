import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/common_libraries.dart';

class DockImageListView extends StatefulWidget {
  const DockImageListView({super.key});

  @override
  State<DockImageListView> createState() => _DockImageListViewState();
}

class _DockImageListViewState extends State<DockImageListView> {
  final CarouselController _controller = CarouselController();

  int index = 0;

  @override
  void initState() {
    context
        .read<ObservationImageDockBloc>()
        .add(ObservationImageDockImageListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationImageDockBloc, ObservationImageDockState>(
      listener: (context, state) {
        CustomNotification(
          context: context,
          notifyType: NotifyType.success,
          content: state.message,
        ).showNotification();
      },
      listenWhen: (previous, current) =>
          previous.imageUploadStatus != current.imageUploadStatus &&
          current.imageUploadStatus.isSuccess,
      builder: (context, state) {
        if (state.imageListLoadStatus.isLoading) {
          return const Center(child: Loader());
        }

        final List<Widget> imageSliders = state.imageList
            .map((item) => Container(
                  margin: inset4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: CachedNetworkImage(
                      imageUrl: item.uri ?? '',
                      placeholder: (context, url) =>
                          const Center(child: Loader(size: 70)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
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
                          onPressed: index >= 0
                              ? () {
                                  _controller.previousPage();
                                  setState(() {
                                    index--;
                                    index %= state.imageList.length;
                                  });
                                }
                              : null,
                          icon: Icon(
                            PhosphorIcons.regular.arrowArcLeft,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      ...Iterable<int>.generate(state.imageList.length).map(
                        (int pageIndex) => Flexible(
                          child: InkWell(
                            onTap: () {
                              _controller.animateToPage(pageIndex);
                              setState(() {
                                index = pageIndex;
                              });
                            },
                            child: Container(
                              decoration: pageIndex == index
                                  ? BoxDecoration(
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    )
                                  : null,
                              child: CachedNetworkImage(
                                imageUrl: state.imageList
                                    .map((e) => e.uri ?? '')
                                    .toList()[pageIndex],
                                placeholder: (context, url) => const Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(bottom: 15.0),
                                  child: Loader(size: 35),
                                )),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                ),
                                height: 50,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: IconButton(
                          onPressed: index < state.imageList.length
                              ? () {
                                  _controller.nextPage();
                                  setState(() {
                                    index++;
                                    index %= state.imageList.length;
                                  });
                                }
                              : null,
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
                if (state.imageList.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        state.imageList[index].originalFileName ?? '',
                        style: textNormal14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
