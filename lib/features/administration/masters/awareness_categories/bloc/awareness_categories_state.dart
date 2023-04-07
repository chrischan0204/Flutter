part of 'awareness_categories_bloc.dart';

class AwarenessCategoriesState extends Equatable {
  final List<AwarenessCategory> awarenessCategories;
  final AwarenessCategory? selectedAwarenessCategory;

  final EntityStatus awarenessCategoriesRetrievedStatus;
  final EntityStatus awarenessCategorySelectedStatus;
  final EntityStatus awarenessCategoryCrudStatus;

  final String message;

  final List<AwarenessGroup> awarenessGroups;
  final EntityStatus awarenessGroupsRetrievedStatus;

  const AwarenessCategoriesState({
    this.awarenessCategories = const [],
    this.awarenessGroups = const [],
    this.selectedAwarenessCategory,
    this.awarenessCategoriesRetrievedStatus = EntityStatus.initial,
    this.awarenessCategorySelectedStatus = EntityStatus.initial,
    this.awarenessCategoryCrudStatus = EntityStatus.initial,
    this.awarenessGroupsRetrievedStatus = EntityStatus.initial,
    this.message = '',
  });

  // set fields for equality of awareness category
  @override
  List<Object?> get props => [
        awarenessCategories,
        awarenessGroups,
        selectedAwarenessCategory,
        awarenessCategoriesRetrievedStatus,
        awarenessCategorySelectedStatus,
        awarenessCategoryCrudStatus,
        awarenessGroupsRetrievedStatus,
        message,
      ];

  // return new awareness category with update fields
  AwarenessCategoriesState copyWith({
    List<AwarenessCategory>? awarenessCategories,
    AwarenessCategory? selectedAwarenessCategory,
    EntityStatus? awarenessCategoriesRetrievedStatus,
    EntityStatus? awarenessCategorySelectedStatus,
    EntityStatus? awarenessCategoryCrudStatus,
    List<AwarenessGroup>? awarenessGroups,
    EntityStatus? awarenessGroupsRetrievedStatus,
    String? message,
  }) {
    return AwarenessCategoriesState(
      awarenessCategories: awarenessCategories ?? this.awarenessCategories,
      selectedAwarenessCategory:
          selectedAwarenessCategory ?? this.selectedAwarenessCategory,
      awarenessCategoriesRetrievedStatus: awarenessCategoriesRetrievedStatus ??
          this.awarenessCategoriesRetrievedStatus,
      awarenessCategorySelectedStatus: awarenessCategorySelectedStatus ??
          this.awarenessCategorySelectedStatus,
      awarenessCategoryCrudStatus:
          awarenessCategoryCrudStatus ?? this.awarenessCategoryCrudStatus,
      awarenessGroups: awarenessGroups ?? this.awarenessGroups,
      awarenessGroupsRetrievedStatus:
          awarenessGroupsRetrievedStatus ?? this.awarenessGroupsRetrievedStatus,
      message: message ?? this.message,
    );
  }
}
