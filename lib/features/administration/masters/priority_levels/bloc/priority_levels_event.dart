part of 'priority_levels_bloc.dart';

abstract class PriorityLevelsEvent extends Equatable {
  const PriorityLevelsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load priority level list
class PriorityLevelsLoaded extends PriorityLevelsEvent {}

/// event to select priority level
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

/// load priority level by id
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

/// create new priority level
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

/// edit prioirity level
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

/// delete priority level by id
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

/// to event to init priority level status
class PriorityLevelsStatusInited extends PriorityLevelsEvent {
  const PriorityLevelsStatusInited();
}
