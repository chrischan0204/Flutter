// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_image_dock_bloc.dart';

abstract class ObservationImageDockEvent extends Equatable {
  const ObservationImageDockEvent();

  @override
  List<Object> get props => [];
}

/// event to load image list
class ObservationImageDockImageListLoaded extends ObservationImageDockEvent {}

/// event to upload images
class ObservationImageDockImageUpLoaded extends ObservationImageDockEvent {}

/// event to change image dock view mode
class ObservationImageDockViewChanged extends ObservationImageDockEvent {
  /// if false, list view
  /// if true, upload view
  final bool view;

  const ObservationImageDockViewChanged({
    required this.view,
  });

  @override
  List<Object> get props => [view];
}

/// event to change image list to upload
class ObservatioinImageDockFileListChanged extends ObservationImageDockEvent {
  final List<PlatformFile> fileList; 

  const ObservatioinImageDockFileListChanged({
    required this.fileList,
  });

  @override
  List<Object> get props => [fileList];
}
