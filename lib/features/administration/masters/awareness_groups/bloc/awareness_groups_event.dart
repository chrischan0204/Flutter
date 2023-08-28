part of 'awareness_groups_bloc.dart';

abstract class AwarenessGroupsEvent extends Equatable {
  const AwarenessGroupsEvent();

  @override
  List<Object?> get props => [];
}

/// event to load awareness group list
class AwarenessGroupsLoaded extends AwarenessGroupsEvent {}

/// event to select awareness group
class AwarenessGroupSelected extends AwarenessGroupsEvent {
  final AwarenessGroup? awarenessGroup;
  const AwarenessGroupSelected({
    this.awarenessGroup,
  });
  @override
  List<Object?> get props => [
        awarenessGroup,
      ];
}

/// event to load awareness group detail
class AwarenessGroupSelectedById extends AwarenessGroupsEvent {
  final String awarenessGroupId;
  const AwarenessGroupSelectedById({
    required this.awarenessGroupId,
  });
  @override
  List<Object> get props => [
        awarenessGroupId,
      ];
}

/// event to delete awareness group by id
class AwarenessGroupDeleted extends AwarenessGroupsEvent {
  final String awarenessGroupId;
  const AwarenessGroupDeleted({
    required this.awarenessGroupId,
  });

  @override
  List<Object> get props => [
        awarenessGroupId,
      ];
}

/// event to init status of awareness group
class AwarenessGroupsStatusInited extends AwarenessGroupsEvent {
  const AwarenessGroupsStatusInited();
}
