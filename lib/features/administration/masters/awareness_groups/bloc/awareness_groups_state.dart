// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'awareness_groups_bloc.dart';

class AwarenessGroupsState extends Equatable {
  final List<AwarenessGroup> awarenessGroups;
  final AwarenessGroup? selectedAwarenessGroup;

  final String message;

  final EntityStatus awarenessGroupsRetrievedStatus;
  final EntityStatus awarenessGroupSelectedStatus;
  final EntityStatus awarenessGroupCrudStatus;
  const AwarenessGroupsState({
    this.awarenessGroups = const [],
    this.selectedAwarenessGroup,
    this.awarenessGroupsRetrievedStatus = EntityStatus.initial,
    this.awarenessGroupSelectedStatus = EntityStatus.initial,
    this.awarenessGroupCrudStatus = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        awarenessGroups,
        selectedAwarenessGroup,
        awarenessGroupsRetrievedStatus,
        awarenessGroupSelectedStatus,
        awarenessGroupCrudStatus,
        message,
      ];

  AwarenessGroupsState copyWith({
    List<AwarenessGroup>? awarenessGroups,
    AwarenessGroup? selectedAwarenessGroup,
    EntityStatus? awarenessGroupsRetrievedStatus,
    EntityStatus? awarenessGroupSelectedStatus,
    EntityStatus? awarenessGroupCrudStatus,
    String? message,
  }) {
    return AwarenessGroupsState(
      awarenessGroups: awarenessGroups ?? this.awarenessGroups,
      selectedAwarenessGroup:
          selectedAwarenessGroup ?? this.selectedAwarenessGroup,
      awarenessGroupsRetrievedStatus:
          awarenessGroupsRetrievedStatus ?? this.awarenessGroupsRetrievedStatus,
      awarenessGroupSelectedStatus:
          awarenessGroupSelectedStatus ?? this.awarenessGroupSelectedStatus,
      awarenessGroupCrudStatus:
          awarenessGroupCrudStatus ?? this.awarenessGroupCrudStatus,
      message: message ?? this.message,
    );
  }
}
