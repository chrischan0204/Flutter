// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'awareness_groups_bloc.dart';

class AwarenessGroupsState extends Equatable {
  final List<AwarenessGroup> awarenessGroups;
  final AwarenessGroup? selectedAwarenessGroup;

  final EntityStatus awarenessGroupsRetrievedStatus;
  final EntityStatus awarenessGroupSelectedStatus;
  final EntityStatus awarenessGroupAddedStatus;
  final EntityStatus awarenessGroupEditedStatus;
  final EntityStatus awarenessGroupDeletedStatus;
  const AwarenessGroupsState({
    this.awarenessGroups = const [],
    this.selectedAwarenessGroup,
    this.awarenessGroupsRetrievedStatus = EntityStatus.initial,
    this.awarenessGroupSelectedStatus = EntityStatus.initial,
    this.awarenessGroupAddedStatus = EntityStatus.initial,
    this.awarenessGroupEditedStatus = EntityStatus.initial,
    this.awarenessGroupDeletedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        awarenessGroups,
        selectedAwarenessGroup,
        awarenessGroupsRetrievedStatus,
        awarenessGroupSelectedStatus,
        awarenessGroupAddedStatus,
        awarenessGroupEditedStatus,
        awarenessGroupDeletedStatus,
      ];

  AwarenessGroupsState copyWith({
    List<AwarenessGroup>? awarenessGroups,
    AwarenessGroup? selectedAwarenessGroup,
    EntityStatus? awarenessGroupsRetrievedStatus,
    EntityStatus? awarenessGroupSelectedStatus,
    EntityStatus? awarenessGroupAddedStatus,
    EntityStatus? awarenessGroupEditedStatus,
    EntityStatus? awarenessGroupDeletedStatus,
  }) {
    return AwarenessGroupsState(
      awarenessGroups: awarenessGroups ?? this.awarenessGroups,
      selectedAwarenessGroup:
          selectedAwarenessGroup ?? this.selectedAwarenessGroup,
      awarenessGroupsRetrievedStatus:
          awarenessGroupsRetrievedStatus ?? this.awarenessGroupsRetrievedStatus,
      awarenessGroupSelectedStatus:
          awarenessGroupSelectedStatus ?? this.awarenessGroupSelectedStatus,
      awarenessGroupAddedStatus:
          awarenessGroupAddedStatus ?? this.awarenessGroupAddedStatus,
      awarenessGroupEditedStatus:
          awarenessGroupEditedStatus ?? this.awarenessGroupEditedStatus,
      awarenessGroupDeletedStatus:
          awarenessGroupDeletedStatus ?? this.awarenessGroupDeletedStatus,
    );
  }
}
