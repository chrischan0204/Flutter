import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:carousel_slider/carousel_slider.dart';
import '/common_libraries.dart';

class AuditObservationListView extends StatelessWidget {
  const AuditObservationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExecuteAuditObservationBloc,
        ExecuteAuditObservationState>(
      listener: (context, state) async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              AuditDetailImageListView(imageList: state.imageList),
        );
      },
      listenWhen: (previous, current) =>
          previous.imageListLoadStatus != current.imageListLoadStatus &&
          current.imageListLoadStatus.isSuccess,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.auditObservationListLoadStatus.isLoading)
              const Center(child: Loader()),
            if (state.auditObservationListLoadStatus.isSuccess)
              for (final observation in state.auditObservationList)
                AuditObservationListItemView(observation: observation)
          ],
        );
      },
    );
  }
}

class AuditObservationListItemView extends StatelessWidget {
  final ObservationDetail observation;
  const AuditObservationListItemView({
    super.key,
    required this.observation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            observation.description ?? '',
            style: textNormal14,
          ),
          spacery10,
          Row(
            children: [
              Expanded(
                  child: Text(
                observation.reportedBy ?? '',
                style: textNormal12,
              )),
              Expanded(
                  child: Text(
                observation.reportedAt != null
                    ? DateFormat('MM/d/yyyy').format(observation.reportedAt!)
                    : '',
                style: textNormal12,
              )),
              Expanded(
                  child: InkWell(
                onTap: observation.imageCount > 0
                    ? () => context.read<ExecuteAuditObservationBloc>().add(
                        ExecuteAuditObservationImageListLoaded(
                            observationId: observation.id))
                    : null,
                child: Text(
                  observation.imageCount < 2
                      ? '${observation.imageCount} Image'
                      : '${observation.imageCount} Images',
                  style: textNormal12.copyWith(color: primaryColor),
                ),
              )),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    context.read<ExecuteAuditObservationBloc>()
                      ..add(const ExecuteAuditObservationViewChanged(
                          view: CrudView.update))
                      ..add(ExecuteAuditObservationLoaded(
                          observationId: observation.id));
                  },
                  icon: Icon(
                    PhosphorIcons.regular.wrench,
                    size: 14,
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    context.read<ExecuteAuditObservationBloc>()
                      ..add(const ExecuteAuditObservationViewChanged(
                          view: CrudView.detail))
                      ..add(ExecuteAuditObservationLoaded(
                          observationId: observation.id));
                  },
                  icon: Icon(
                    PhosphorIcons.regular.appWindow,
                    size: 14,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    CustomAlert(
                      context: context,
                      width: MediaQuery.of(context).size.width / 4,
                      title: 'Notification',
                      description: 'Deleting observation. Are you sure?',
                      btnOkText: 'OK',
                      btnOkOnPress: () => context
                          .read<ExecuteAuditObservationBloc>()
                          .add(ExecuteAuditObservationDeleted(
                              observationId: observation.id)),
                      btnCancelOnPress: () {},
                      dialogType: DialogType.info,
                    ).show();
                  },
                  icon: Icon(
                    PhosphorIcons.regular.trash,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
                      const Center(child: Loader(size: 30)),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: 30,
                  ),
                  fit: BoxFit.fitWidth,
                  width: 1000.0,
                ),
              ),
            ))
        .toList();

    // final documentList = widget.imageList
    //     .where((element) => !element.documentType!.isImage)
    //     .toList();
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
                padding: insety20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: inset10,
                      child: Text(
                        'These images were uploaded in this observation...',
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
                                ...Iterable<int>.generate(
                                        widget.imageList.length)
                                    .map(
                                  (int pageIndex) => Flexible(
                                    child: InkWell(
                                      onTap: () =>
                                          _controller.animateToPage(pageIndex),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.imageList
                                            .where((element) =>
                                                element.documentType!.isImage)
                                            .map((e) => e.uri ?? '')
                                            .toList()[pageIndex],
                                        placeholder: (context, url) =>
                                            const Center(
                                                child: Loader(size: 30)),
                                        errorWidget: (context, url, error) =>
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
