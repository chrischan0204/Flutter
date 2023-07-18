// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'observation_detail_bloc.dart';

class ObservationDetailState extends Equatable {
  /// observation for detail
  final ObservationDetail? observation;
  final EntityStatus observationLoadStatus;
  final EntityStatus observationDeleteStatus;

  /// awareness category list
  final List<AwarenessCategory> awarenessCategoryList;

  /// observation type list
  final List<ObservationType> observationTypeList;

  /// priority level list
  final List<PriorityLevel> priorityLevelList;

  /// company list
  final List<Company> companyList;

  /// project list
  final List<Project> projectList;

  /// site list
  final List<Site> siteList;

  /// user list
  final List<User> userList;

  

  final String message;
  const ObservationDetailState({
    this.observation,
    this.observationLoadStatus = EntityStatus.initial,
    this.observationDeleteStatus = EntityStatus.initial,
    this.awarenessCategoryList = const [],
    this.observationTypeList = const [],
    this.priorityLevelList = const [],
    this.companyList = const [],
    this.projectList = const [],
    this.siteList = const [],
    this.userList = const [],
    this.message = '',
  });

  @override
  List<Object?> get props => [
        observation,
        awarenessCategoryList,
        priorityLevelList,
        observationTypeList,
        companyList,
        projectList,
        siteList,
        userList,
        observationLoadStatus,
        observationDeleteStatus,
        message,
      ];

  ObservationDetailState copyWith({
    ObservationDetail? observation,
    EntityStatus? observationLoadStatus,
    EntityStatus? observationDeleteStatus,
    List<AwarenessCategory>? awarenessCategoryList,
    List<ObservationType>? observationTypeList,
    List<PriorityLevel>? priorityLevelList,
    List<Company>? companyList,
    List<Project>? projectList,
    List<Site>? siteList,
    List<User>? userList,
    String? message,
  }) {
    return ObservationDetailState(
      observation: observation ?? this.observation,
      observationLoadStatus:
          observationLoadStatus ?? this.observationLoadStatus,
      observationDeleteStatus:
          observationDeleteStatus ?? this.observationDeleteStatus,
      awarenessCategoryList:
          awarenessCategoryList ?? this.awarenessCategoryList,
      observationTypeList: observationTypeList ?? this.observationTypeList,
      priorityLevelList: priorityLevelList ?? this.priorityLevelList,
      companyList: companyList ?? this.companyList,
      projectList: projectList ?? this.projectList,
      siteList: siteList ?? this.siteList,
      userList: userList ?? this.userList,
      message: message ?? this.message,
    );
  }
}
