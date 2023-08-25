part of 'awareness_categories_bloc.dart';

class AwarenessCategoriesState extends Equatable {
  final List<AwarenessCategory> awarenessCategories;
  final AwarenessCategory? selectedAwarenessCategory;

  final EntityStatus awarenessCategoriesLoadedStatus;
  final EntityStatus awarenessCategorySelectedStatus;
  final EntityStatus awarenessCategoryCrudStatus;

  final String message;

  final List<AwarenessGroup> awarenessGroups;
  final EntityStatus awarenessGroupsLoadedStatus;

  const AwarenessCategoriesState({
    this.awarenessCategories = const [],
    this.awarenessGroups = const [],
    this.selectedAwarenessCategory,
    this.awarenessCategoriesLoadedStatus = EntityStatus.initial,
    this.awarenessCategorySelectedStatus = EntityStatus.initial,
    this.awarenessCategoryCrudStatus = EntityStatus.initial,
    this.awarenessGroupsLoadedStatus = EntityStatus.initial,
    this.message = '',
  });

  // set fields for equality of awareness category
  @override
  List<Object?> get props => [
        awarenessCategories,
        awarenessGroups,
        selectedAwarenessCategory,
        awarenessCategoriesLoadedStatus,
        awarenessCategorySelectedStatus,
        awarenessCategoryCrudStatus,
        awarenessGroupsLoadedStatus,
        message,
      ];

  // return new awareness category with update fields
  AwarenessCategoriesState copyWith({
    List<AwarenessCategory>? awarenessCategories,
    AwarenessCategory? selectedAwarenessCategory,
    EntityStatus? awarenessCategoriesLoadedStatus,
    EntityStatus? awarenessCategorySelectedStatus,
    EntityStatus? awarenessCategoryCrudStatus,
    List<AwarenessGroup>? awarenessGroups,
    EntityStatus? awarenessGroupsLoadedStatus,
    String? message,
  }) {
    return AwarenessCategoriesState(
      awarenessCategories: awarenessCategories ?? this.awarenessCategories,
      selectedAwarenessCategory:
          selectedAwarenessCategory ?? this.selectedAwarenessCategory,
      awarenessCategoriesLoadedStatus: awarenessCategoriesLoadedStatus ??
          this.awarenessCategoriesLoadedStatus,
      awarenessCategorySelectedStatus: awarenessCategorySelectedStatus ??
          this.awarenessCategorySelectedStatus,
      awarenessCategoryCrudStatus:
          awarenessCategoryCrudStatus ?? this.awarenessCategoryCrudStatus,
      awarenessGroups: awarenessGroups ?? this.awarenessGroups,
      awarenessGroupsLoadedStatus:
          awarenessGroupsLoadedStatus ?? this.awarenessGroupsLoadedStatus,
      message: message ?? this.message,
    );
  }
}
