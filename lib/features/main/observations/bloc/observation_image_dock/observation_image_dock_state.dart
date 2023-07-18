part of 'observation_image_dock_bloc.dart';

class ObservationImageDockState extends Equatable {
  final List<Document> imageList;
  final List<PlatformFile> fileList;
  final EntityStatus imageListLoadStatus;
  final EntityStatus imageUploadStatus;
  final bool isUploadView;

  const ObservationImageDockState({
    this.imageList = const [],
    this.fileList = const [],
    this.imageListLoadStatus = EntityStatus.initial,
    this.imageUploadStatus = EntityStatus.initial,
    this.isUploadView = false,
  });

  @override
  List<Object> get props => [
        imageList,
        fileList,
        imageListLoadStatus,
        imageUploadStatus,
        isUploadView,
      ];

  ObservationImageDockState copyWith({
    List<Document>? imageList,
    List<PlatformFile>? fileList,
    EntityStatus? imageListLoadStatus,
    EntityStatus? imageUploadStatus,
    bool? isUploadView,
  }) {
    return ObservationImageDockState(
      imageList: imageList ?? this.imageList,
      fileList: fileList ?? this.fileList,
      imageListLoadStatus: imageListLoadStatus ?? this.imageListLoadStatus,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      isUploadView: isUploadView ?? this.isUploadView,
    );
  }
}
