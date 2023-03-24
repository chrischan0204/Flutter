part of 'priority_levels_bloc.dart';

abstract class PriorityLevelsEvent extends Equatable {
  const PriorityLevelsEvent();

  @override
  List<Object?> get props => [];
}

class PriorityLevelsRetrieved extends PriorityLevelsEvent {}

class PriorityLevelSelected extends PriorityLevelsEvent {
  final PriorityLevel? priorityLevel;
  const PriorityLevelSelected({
    this.priorityLevel,
  });
  @override
  List<Object?> get props => [
        priorityLevel,
      ];
}

class PriorityLevelSelectedById extends PriorityLevelsEvent {
  final String priorityLevelId;
  const PriorityLevelSelectedById({
    required this.priorityLevelId,
  });
  @override
  List<Object> get props => [
        priorityLevelId,
      ];
}

class PriorityLevelAdded extends PriorityLevelsEvent {
  final PriorityLevel priorityLevel;
  const PriorityLevelAdded({
    required this.priorityLevel,
  });

  @override
  List<Object> get props => [
        priorityLevel,
      ];
}

class PriorityLevelEdited extends PriorityLevelsEvent {
  final PriorityLevel priorityLevel;
  const PriorityLevelEdited({
    required this.priorityLevel,
  });

  @override
  List<Object> get props => [
        priorityLevel,
      ];
}

class PriorityLevelDeleted extends PriorityLevelsEvent {
  final String priorityLevelId;
  const PriorityLevelDeleted({
    required this.priorityLevelId,
  });

  @override
  List<Object> get props => [
        priorityLevelId,
      ];
}

class PriorityLevelsStatusInited extends PriorityLevelsEvent {
  const PriorityLevelsStatusInited();
}
