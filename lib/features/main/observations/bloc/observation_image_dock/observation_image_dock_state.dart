part of 'observation_image_dock_bloc.dart';

class ObservationImageDockState extends Equatable {
  final List<Document> imageList;
  final List<PlatformFile> fileList;
  final EntityStatus imageListLoadStatus;
  final EntityStatus imageUploadStatus;
  final bool isUploadView;
  final String message;

  const ObservationImageDockState({
    this.imageList = const [],
    this.fileList = const [],
    this.imageListLoadStatus = EntityStatus.initial,
    this.imageUploadStatus = EntityStatus.initial,
    this.isUploadView = false,
    this.message = '',
  });

  @override
  List<Object> get props => [
        imageList,
        fileList,
        imageListLoadStatus,
        imageUploadStatus,
        isUploadView,
        message,
      ];

  ObservationImageDockState copyWith({
    List<Document>? imageList,
    List<PlatformFile>? fileList,
    EntityStatus? imageListLoadStatus,
    EntityStatus? imageUploadStatus,
    bool? isUploadView,
    String? message,
  }) {
    return ObservationImageDockState(
      imageList: imageList ?? this.imageList,
      fileList: fileList ?? this.fileList,
      imageListLoadStatus: imageListLoadStatus ?? this.imageListLoadStatus,
      imageUploadStatus: imageUploadStatus ?? this.imageUploadStatus,
      isUploadView: isUploadView ?? this.isUploadView,
      message: message ?? this.message,
    );
  }
}
