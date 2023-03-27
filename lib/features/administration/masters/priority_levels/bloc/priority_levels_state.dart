// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'priority_levels_bloc.dart';

class PriorityLevelsState extends Equatable {
  final List<PriorityLevel> priorityLevels;
  final PriorityLevel? selectedPriorityLevel;

  final EntityStatus priorityLevelsRetrievedStatus;
  final EntityStatus priorityLevelSelectedStatus;
  final EntityStatus priorityLevelAddedStatus;
  final EntityStatus priorityLevelEditedStatus;
  final EntityStatus priorityLevelDeletedStatus;
  const PriorityLevelsState({
    this.priorityLevels = const [],
    this.selectedPriorityLevel,
    this.priorityLevelsRetrievedStatus = EntityStatus.initial,
    this.priorityLevelSelectedStatus = EntityStatus.initial,
    this.priorityLevelAddedStatus = EntityStatus.initial,
    this.priorityLevelEditedStatus = EntityStatus.initial,
    this.priorityLevelDeletedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        priorityLevels,
        priorityLevelsRetrievedStatus,
        selectedPriorityLevel,
        priorityLevelSelectedStatus,
        priorityLevelAddedStatus,
        priorityLevelEditedStatus,
        priorityLevelDeletedStatus,
      ];

  PriorityLevelsState copyWith({
    List<PriorityLevel>? priorityLevels,
    PriorityLevel? selectedPriorityLevel,
    EntityStatus? priorityLevelsRetrievedStatus,
    EntityStatus? priorityLevelSelectedStatus,
    EntityStatus? priorityLevelAddedStatus,
    EntityStatus? priorityLevelEditedStatus,
    EntityStatus? priorityLevelDeletedStatus,
  }) {
    return PriorityLevelsState(
      priorityLevels: priorityLevels ?? this.priorityLevels,
      selectedPriorityLevel:
          selectedPriorityLevel ?? this.selectedPriorityLevel,
      priorityLevelsRetrievedStatus:
          priorityLevelsRetrievedStatus ?? this.priorityLevelsRetrievedStatus,
      priorityLevelSelectedStatus:
          priorityLevelSelectedStatus ?? this.priorityLevelSelectedStatus,
      priorityLevelAddedStatus:
          priorityLevelAddedStatus ?? this.priorityLevelAddedStatus,
      priorityLevelEditedStatus:
          priorityLevelEditedStatus ?? this.priorityLevelEditedStatus,
      priorityLevelDeletedStatus:
          priorityLevelDeletedStatus ?? this.priorityLevelDeletedStatus,
    );
  }
}
