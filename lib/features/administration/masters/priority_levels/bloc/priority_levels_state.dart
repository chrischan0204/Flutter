// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'priority_levels_bloc.dart';

class PriorityLevelsState extends Equatable {
  final List<PriorityLevel> priorityLevels;
  final PriorityLevel? selectedPriorityLevel;

  final EntityStatus priorityLevelsLoadedStatus;
  final EntityStatus priorityLevelSelectedStatus;
  final EntityStatus priorityLevelCrudStatus;

  final String message;
  const PriorityLevelsState({
    this.priorityLevels = const [],
    this.selectedPriorityLevel,
    this.priorityLevelsLoadedStatus = EntityStatus.initial,
    this.priorityLevelSelectedStatus = EntityStatus.initial,
    this.priorityLevelCrudStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        priorityLevels,
        priorityLevelsLoadedStatus,
        selectedPriorityLevel,
        priorityLevelSelectedStatus,
        priorityLevelCrudStatus,
        message,
      ];

  PriorityLevelsState copyWith({
    List<PriorityLevel>? priorityLevels,
    PriorityLevel? selectedPriorityLevel,
    EntityStatus? priorityLevelsLoadedStatus,
    EntityStatus? priorityLevelSelectedStatus,
    EntityStatus? priorityLevelCrudStatus,
    String? message,
  }) {
    return PriorityLevelsState(
      priorityLevels: priorityLevels ?? this.priorityLevels,
      selectedPriorityLevel:
          selectedPriorityLevel ?? this.selectedPriorityLevel,
      priorityLevelsLoadedStatus:
          priorityLevelsLoadedStatus ?? this.priorityLevelsLoadedStatus,
      priorityLevelSelectedStatus:
          priorityLevelSelectedStatus ?? this.priorityLevelSelectedStatus,
      priorityLevelCrudStatus:
          priorityLevelCrudStatus ?? this.priorityLevelCrudStatus,
      message: message ?? this.message,
    );
  }
}
