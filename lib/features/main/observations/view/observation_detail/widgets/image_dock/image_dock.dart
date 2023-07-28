import '/common_libraries.dart';
import 'widgets/widgets.dart';

class ObservationImageDockView extends StatelessWidget {
  const ObservationImageDockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: BlocBuilder<ObservationImageDockBloc, ObservationImageDockState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomBottomBorderContainer(
                backgroundColor: lightBlueAccent,
                padding: inset20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Image Dock',
                      style: textSemiBold14,
                    ),
                    Row(
                      children: [
                        if (state.isUploadView)
                          ElevatedButton(
                            onPressed: state.fileList.isNotEmpty
                                ? () => context
                                    .read<ObservationImageDockBloc>()
                                    .add(ObservationImageDockImageUpLoaded())
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: successColor),
                            child: Text(
                              'Upload Images',
                              style: textNormal14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (state.isUploadView) spacerx10,
                        ElevatedButton(
                          onPressed: () => context
                              .read<ObservationImageDockBloc>()
                              .add(ObservationImageDockViewChanged(
                                  view: !state.isUploadView)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: state.isUploadView
                                  ? warnColor
                                  : primaryColor),
                          child: Text(
                            state.isUploadView ? 'Cancel' : 'Add Images',
                            style: textNormal14.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              if (!state.isUploadView) const DockImageListView(),
              if (state.isUploadView) const DockImageUploadView(),
            ],
          );
        },
      ),
    );
  }
}
