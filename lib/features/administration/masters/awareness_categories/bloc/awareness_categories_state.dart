// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'awareness_categories_bloc.dart';

class AwarenessCategoriesState extends Equatable {
  final List<AwarenessCategory> awarenessCategories;
  final AwarenessCategory? selectedAwarenessCategory;

  final EntityStatus awarenessCategoriesRetrievedStatus;
  final EntityStatus awarenessCategorySelectedStatus;
  final EntityStatus awarenessCategoryAddedStatus;
  final EntityStatus awarenessCategoryEditedStatus;
  final EntityStatus awarenessCategoryDeletedStatus;

  final List<String> awarenessGroups;
  final EntityStatus awarenessGroupsRetrievedStatus;

  const AwarenessCategoriesState({
    this.awarenessCategories = const [],
    this.awarenessGroups = const [],
    this.selectedAwarenessCategory,
    this.awarenessCategoriesRetrievedStatus = EntityStatus.initial,
    this.awarenessCategorySelectedStatus = EntityStatus.initial,
    this.awarenessCategoryAddedStatus = EntityStatus.initial,
    this.awarenessCategoryEditedStatus = EntityStatus.initial,
    this.awarenessCategoryDeletedStatus = EntityStatus.initial,
    this.awarenessGroupsRetrievedStatus = EntityStatus.initial,
  });

  @override
  List<Object?> get props => [
        awarenessCategories,
        awarenessGroups,
        selectedAwarenessCategory,
        awarenessCategoriesRetrievedStatus,
        awarenessCategorySelectedStatus,
        awarenessCategoryAddedStatus,
        awarenessCategoryEditedStatus,
        awarenessCategoryDeletedStatus,
        awarenessGroupsRetrievedStatus,
      ];

  AwarenessCategoriesState copyWith({
    List<AwarenessCategory>? awarenessCategories,
    AwarenessCategory? selectedAwarenessCategory,
    EntityStatus? awarenessCategoriesRetrievedStatus,
    EntityStatus? awarenessCategorySelectedStatus,
    EntityStatus? awarenessCategoryAddedStatus,
    EntityStatus? awarenessCategoryEditedStatus,
    EntityStatus? awarenessCategoryDeletedStatus,
    List<String>? awarenessGroups,
    EntityStatus? awarenessGroupsRetrievedStatus,
  }) {
    return AwarenessCategoriesState(
      awarenessCategories: awarenessCategories ?? this.awarenessCategories,
      selectedAwarenessCategory:
          selectedAwarenessCategory ?? this.selectedAwarenessCategory,
      awarenessCategoriesRetrievedStatus: awarenessCategoriesRetrievedStatus ??
          this.awarenessCategoriesRetrievedStatus,
      awarenessCategorySelectedStatus: awarenessCategorySelectedStatus ??
          this.awarenessCategorySelectedStatus,
      awarenessCategoryAddedStatus:
          awarenessCategoryAddedStatus ?? this.awarenessCategoryAddedStatus,
      awarenessCategoryEditedStatus:
          awarenessCategoryEditedStatus ?? this.awarenessCategoryEditedStatus,
      awarenessCategoryDeletedStatus:
          awarenessCategoryDeletedStatus ?? this.awarenessCategoryDeletedStatus,
      awarenessGroups: awarenessGroups ?? this.awarenessGroups,
      awarenessGroupsRetrievedStatus:
          awarenessGroupsRetrievedStatus ?? this.awarenessGroupsRetrievedStatus,
    );
  }
}
