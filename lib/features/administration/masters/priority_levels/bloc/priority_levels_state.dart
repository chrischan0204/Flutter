// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'priority_levels_bloc.dart';

class PriorityLevelsState extends Equatable {
  final List<PriorityLevel> priorityLevels;
  final PriorityLevel? selectedPriorityLevel;

  final EntityStatus priorityLevelsRetrievedStatus;
  final EntityStatus priorityLevelSelectedStatus;
  final EntityStatus priorityLevelCrudStatus;

  final String message;
  const PriorityLevelsState({
    this.priorityLevels = const [],
    this.selectedPriorityLevel,
    this.priorityLevelsRetrievedStatus = EntityStatus.initial,
    this.priorityLevelSelectedStatus = EntityStatus.initial,
    this.priorityLevelCrudStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        priorityLevels,
        priorityLevelsRetrievedStatus,
        selectedPriorityLevel,
        priorityLevelSelectedStatus,
        priorityLevelCrudStatus,
        message,
      ];

  PriorityLevelsState copyWith({
    List<PriorityLevel>? priorityLevels,
    PriorityLevel? selectedPriorityLevel,
    EntityStatus? priorityLevelsRetrievedStatus,
    EntityStatus? priorityLevelSelectedStatus,
    EntityStatus? priorityLevelCrudStatus,
    String? message,
  }) {
    return PriorityLevelsState(
      priorityLevels: priorityLevels ?? this.priorityLevels,
      selectedPriorityLevel:
          selectedPriorityLevel ?? this.selectedPriorityLevel,
      priorityLevelsRetrievedStatus:
          priorityLevelsRetrievedStatus ?? this.priorityLevelsRetrievedStatus,
      priorityLevelSelectedStatus:
          priorityLevelSelectedStatus ?? this.priorityLevelSelectedStatus,
      priorityLevelCrudStatus:
          priorityLevelCrudStatus ?? this.priorityLevelCrudStatus,
      message: message ?? this.message,
    );
  }
}
