// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_scale_bloc.dart';

class ResponseScaleEvent extends Equatable {
  const ResponseScaleEvent();

  @override
  List<Object> get props => [];
}

class ResponseScaleListLoaded extends ResponseScaleEvent {}

class ResponseScaleSelected extends ResponseScaleEvent {
  final String selectedResponseScaleId;
  const ResponseScaleSelected({
    required this.selectedResponseScaleId,
  });

  @override
  List<Object> get props => [selectedResponseScaleId];
}

class ResponseScaleAdded extends ResponseScaleEvent {}

class ResponseScaleEdited extends ResponseScaleEvent {
  final String responseScaleId;
  final String responseScaleName;
  const ResponseScaleEdited({
    required this.responseScaleId,
    required this.responseScaleName,
  });

  @override
  List<Object> get props => [
        responseScaleId,
        responseScaleName,
      ];
}

class ResponseScaleDeleted extends ResponseScaleEvent {
  final String responseScaleId;
  const ResponseScaleDeleted({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}

class ResponseScaleListSorted extends ResponseScaleEvent {
  final Key currentId;
  final Key newId;

  const ResponseScaleListSorted({
    required this.currentId,
    required this.newId,
  });

  @override
  List<Object> get props => [
        currentId,
        newId,
      ];
}

class ResponseScaleNewResponseScaleChanged extends ResponseScaleEvent {
  final String responseScale;
  const ResponseScaleNewResponseScaleChanged({
    required this.responseScale,
  });
  @override
  List<Object> get props => [responseScale];
}

class ResponseScaleItemListLoaded extends ResponseScaleEvent {
  final String responseScaleId;
  const ResponseScaleItemListLoaded({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}

class ResponseScaleItemAdded extends ResponseScaleEvent {}

class ResponseScaleItemListSaved extends ResponseScaleEvent {}

class ResponseScaleItemNameChanged extends ResponseScaleEvent {
  final int index;
  final String responseScaleItemName;

  const ResponseScaleItemNameChanged({
    required this.index,
    required this.responseScaleItemName,
  });

  @override
  List<Object> get props => [
        index,
        responseScaleItemName,
      ];
}

class ResponseScaleItemIsRequiredChanged extends ResponseScaleEvent {
  final int index;
  final bool isRequired;

  const ResponseScaleItemIsRequiredChanged({
    required this.index,
    required this.isRequired,
  });

  @override
  List<Object> get props => [
        index,
        isRequired,
      ];
}

class ResponseScaleItemScoreChanged extends ResponseScaleEvent {
  final int index;
  final String score;

  const ResponseScaleItemScoreChanged({
    required this.index,
    required this.score,
  });

  @override
  List<Object> get props => [
        index,
        score,
      ];
}

class ResponseScaleItemDeleted extends ResponseScaleEvent {
  final int index;
  const ResponseScaleItemDeleted({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class ResponseScaleItemListSorted extends ResponseScaleEvent {
  final Key currentId;
  final Key newId;

  const ResponseScaleItemListSorted({
    required this.currentId,
    required this.newId,
  });

  @override
  List<Object> get props => [
        currentId,
        newId,
      ];
}
