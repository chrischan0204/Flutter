// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'awareness_categories_bloc.dart';

class AwarenessCategoriesState extends Equatable {
  final List<AwarenessCategory> awarenessCategories;
  final EntityStatus awarenessCategoriesRetrievedStatus;
  final List<String> awarenessGroups;
  final EntityStatus awarenessGroupsRetrievedStatus;

  const AwarenessCategoriesState({
    this.awarenessCategories = const [],
    this.awarenessCategoriesRetrievedStatus = EntityStatus.initial,
    this.awarenessGroups = const [],
    this.awarenessGroupsRetrievedStatus = EntityStatus.initial,
  });

  @override
  List<Object> get props => [
        awarenessCategories,
        awarenessCategoriesRetrievedStatus,
      ];

  AwarenessCategoriesState copyWith({
    List<AwarenessCategory>? awarenessCategories,
    EntityStatus? awarenessCategoriesRetrievedStatus,
  }) {
    return AwarenessCategoriesState(
      awarenessCategories: awarenessCategories ?? this.awarenessCategories,
      awarenessCategoriesRetrievedStatus: awarenessCategoriesRetrievedStatus ?? this.awarenessCategoriesRetrievedStatus,
    );
  }
}
