part of 'awareness_groups_bloc.dart';

abstract class AwarenessGroupsEvent extends Equatable {
  const AwarenessGroupsEvent();

  @override
  List<Object?> get props => [];
}

class AwarenessGroupsRetrieved extends AwarenessGroupsEvent {}

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

class AwarenessGroupAdded extends AwarenessGroupsEvent {
  final AwarenessGroup awarenessGroup;
  const AwarenessGroupAdded({
    required this.awarenessGroup,
  });

  @override
  List<Object> get props => [
        awarenessGroup,
      ];
}

class AwarenessGroupEdited extends AwarenessGroupsEvent {
  final AwarenessGroup awarenessGroup;
  const AwarenessGroupEdited({
    required this.awarenessGroup,
  });

  @override
  List<Object> get props => [
        awarenessGroup,
      ];
}

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

class AwarenessGroupsStatusInited extends AwarenessGroupsEvent {
  const AwarenessGroupsStatusInited();
}
