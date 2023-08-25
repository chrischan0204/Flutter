part of 'awareness_categories_bloc.dart';

abstract class AwarenessCategoriesEvent extends Equatable {
  const AwarenessCategoriesEvent();

  @override
  List<Object?> get props => [];
}

/// event to load category list
class AwarenessCategoriesLoaded extends AwarenessCategoriesEvent {}

/// event to load awarness group list
class AwarenessGroupsForAwarenessCategoriesLoaded
    extends AwarenessCategoriesEvent {}

class AwarenessCategorySelected extends AwarenessCategoriesEvent {
  final AwarenessCategory? awarenessCategory;
  const AwarenessCategorySelected({
    this.awarenessCategory,
  });
  @override
  List<Object?> get props => [
        awarenessCategory,
      ];
}

/// event to load awareness category detail by id
class AwarenessCategorySelectedById extends AwarenessCategoriesEvent {
  final String awarenessCategoryId;
  const AwarenessCategorySelectedById({
    required this.awarenessCategoryId,
  });
  @override
  List<Object> get props => [
        awarenessCategoryId,
      ];
}

/// event to delete awareness category by id
class AwarenessCategoryDeleted extends AwarenessCategoriesEvent {
  final String awarenessCategoryId;
  const AwarenessCategoryDeleted({
    required this.awarenessCategoryId,
  });

  @override
  List<Object> get props => [
        awarenessCategoryId,
      ];
}

/// event to init state
class AwarenessCategoriesStatusInited extends AwarenessCategoriesEvent {
  const AwarenessCategoriesStatusInited();
}
