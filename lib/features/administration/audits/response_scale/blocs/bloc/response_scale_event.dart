// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_scale_bloc.dart';

class ResponseScaleEvent extends Equatable {
  const ResponseScaleEvent();

  @override
  List<Object> get props => [];
}

/// event to load response scale list
class ResponseScaleListLoaded extends ResponseScaleEvent {}

/// event to select response scale
class ResponseScaleSelected extends ResponseScaleEvent {
  final String selectedResponseScaleId;
  const ResponseScaleSelected({
    required this.selectedResponseScaleId,
  });

  @override
  List<Object> get props => [selectedResponseScaleId];
}

/// event to add response scale
class ResponseScaleAdded extends ResponseScaleEvent {}

/// event to edit response scale
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

/// event to delete resonse scale
class ResponseScaleDeleted extends ResponseScaleEvent {
  final String responseScaleId;
  const ResponseScaleDeleted({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}

/// event to sort resonse scale list
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

/// event to change response scale to create
class ResponseScaleNewResponseScaleChanged extends ResponseScaleEvent {
  final String responseScale;
  const ResponseScaleNewResponseScaleChanged({
    required this.responseScale,
  });
  @override
  List<Object> get props => [responseScale];
}

/// event to load response scale item list
class ResponseScaleItemListLoaded extends ResponseScaleEvent {
  final String responseScaleId;
  const ResponseScaleItemListLoaded({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}

/// event to add resonse scale item
class ResponseScaleItemAdded extends ResponseScaleEvent {}

/// event to save response scale item list
class ResponseScaleItemListSaved extends ResponseScaleEvent {}

/// event to change response scale item name at index position
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

/// event to change response scale item isRequired at index position
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

/// event to change response scale item score at index position
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

/// event to delete response scale item at index position
class ResponseScaleItemDeleted extends ResponseScaleEvent {
  final int index;
  const ResponseScaleItemDeleted({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

/// event to sort response scale item list
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

/// event to validate if response scale can be deleted
class ResponseScaleDeletionValidated extends ResponseScaleEvent {
  final String responseScaleId;

  const ResponseScaleDeletionValidated({
    required this.responseScaleId,
  });

  @override
  List<Object> get props => [responseScaleId];
}
