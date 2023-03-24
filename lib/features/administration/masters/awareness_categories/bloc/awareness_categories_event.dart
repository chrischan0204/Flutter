part of 'awareness_categories_bloc.dart';

abstract class AwarenessCategoriesEvent extends Equatable {
  const AwarenessCategoriesEvent();

  @override
  List<Object?> get props => [];
}

class AwarenessCategoriesRetrieved extends AwarenessCategoriesEvent {}

class AwarenessGroupsForAwarenessCategoriesRetrieved extends AwarenessCategoriesEvent {}

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

class AwarenessCategoryAdded extends AwarenessCategoriesEvent {
  final AwarenessCategory awarenessCategory;
  const AwarenessCategoryAdded({
    required this.awarenessCategory,
  });

  @override
  List<Object> get props => [
        awarenessCategory,
      ];
}

class AwarenessCategoryEdited extends AwarenessCategoriesEvent {
  final AwarenessCategory awarenessCategory;
  const AwarenessCategoryEdited({
    required this.awarenessCategory,
  });

  @override
  List<Object> get props => [
        awarenessCategory,
      ];
}

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

class AwarenessCategoriesStatusInited extends AwarenessCategoriesEvent {
  const AwarenessCategoriesStatusInited();
}
