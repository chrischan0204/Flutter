import '/common_libraries.dart';

part 'observation_detail_event.dart';
part 'observation_detail_state.dart';

class ObservationDetailBloc
    extends Bloc<ObservationDetailEvent, ObservationDetailState> {
  final BuildContext context;
  final String observationId;
  late ObservationsRepository observationsRepository;
  late SitesRepository _sitesRepository;
  late ProjectsRepository projectsRepository;
  late PriorityLevelsRepository priorityLevelsRepository;
  late AwarenessCategoriesRepository awarenessCategoriesRepository;
  late CompaniesRepository companiesRepository;
  late ObservationTypesRepository _observationTypesRepository;
  late UsersRepository _usersRepository;

  late AuthBloc _authBloc;

  ObservationDetailBloc({
    required this.context,
    required this.observationId,
  }) : super(const ObservationDetailState()) {
    observationsRepository = RepositoryProvider.of(context);
    _sitesRepository = RepositoryProvider.of(context);
    projectsRepository = RepositoryProvider.of(context);
    _observationTypesRepository = RepositoryProvider.of(context);
    priorityLevelsRepository = RepositoryProvider.of(context);
    awarenessCategoriesRepository = RepositoryProvider.of(context);
    companiesRepository = RepositoryProvider.of(context);
    _usersRepository = RepositoryProvider.of(context);

    _authBloc = context.read();

    _bindEvents();
  }

  void _bindEvents() {
    on<ObservationDetailLoaded>(_onObservationDetailLoaded);
    on<ObservationDetailObservationDeleted>(
        _onObservationDetailObservationDeleted);
    on<ObservationDetailCompanyListLoaded>(
        _onObservationDetailCompanyListLoaded);
    on<ObservationDetailObservationTypeListLoaded>(
        _onObservationDetailObservationTypeListLoaded);
    on<ObservationDetailSiteListLoaded>(_onObservationDetailSiteListLoaded);
    on<ObservationDetailProjectListLoaded>(
        _onObservationDetailProjectListLoaded);
    on<ObservationDetailAwarenessCategoryListLoaded>(
        _onObservationDetailAwarenessCategoryListLoaded);
    on<ObservationDetailPriorityLevelListLoaded>(
        _onObservationDetailPriorityLevelListLoaded);
    on<ObservationDetailUserListLoaded>(_onObservationDetailUserListLoaded);
  }

  Future<void> _onObservationDetailLoaded(
    ObservationDetailLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      ObservationDetail observation =
          await observationsRepository.getObservationById(event.observationId);

      emit(state.copyWith(observation: observation));
    } catch (e) {}
  }

  Future<void> _onObservationDetailObservationDeleted(
    ObservationDetailObservationDeleted event,
    Emitter<ObservationDetailState> emit,
  ) async {}

  Future<void> _onObservationDetailAwarenessCategoryListLoaded(
    ObservationDetailAwarenessCategoryListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Entity> awarenessCategoryList =
        await awarenessCategoriesRepository.getActiveAwarenessCategorieList();

    emit(state.copyWith(
        awarenessCategoryList: awarenessCategoryList
            .map((e) => AwarenessCategory(id: e.id, name: e.name))
            .toList()));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailSiteListLoaded(
    ObservationDetailSiteListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      List<UserSite> siteList = await _usersRepository
          .getSiteListForUser(_authBloc.state.authUser!.id);

      emit(state.copyWith(
          siteList: siteList
              .map((e) => Site(
                    id: e.siteId,
                    name: e.siteName,
                  ))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onObservationDetailCompanyListLoaded(
    ObservationDetailCompanyListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      List<CompanySite> companyList =
          await _sitesRepository.getCompanyListForSite(event.siteId);

      emit(state.copyWith(
          companyList: companyList
              .map((e) => Company(id: e.companyId, name: e.companyName))
              .toList()));
    } catch (e) {}
  }

  Future<void> _onObservationDetailProjectListLoaded(
    ObservationDetailProjectListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      List<Project> projectList =
          await _sitesRepository.getProjectListForSite(event.siteId);

      emit(state.copyWith(projectList: projectList));
    } catch (e) {}
  }

  Future<void> _onObservationDetailPriorityLevelListLoaded(
    ObservationDetailPriorityLevelListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Entity> priorityLevelList =
        await priorityLevelsRepository.getActivePriorityLevelList();

    emit(state.copyWith(
        priorityLevelList: priorityLevelList
            .map((e) => PriorityLevel(
                  colorCode: Colors.white,
                  priorityType: '',
                  id: e.id,
                  name: e.name,
                ))
            .toList()));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailObservationTypeListLoaded(
    ObservationDetailObservationTypeListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Entity> observationTypeList =
        await _observationTypesRepository.getActiveObservationTypeList();

    emit(state.copyWith(
      observationTypeList: observationTypeList
          .map((e) => ObservationType(severity: '', id: e.id, name: e.name))
          .toList(),
    ));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailUserListLoaded(
    ObservationDetailUserListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<User> userList = await _usersRepository.getUserList();

    emit(state.copyWith(userList: userList));
    try {} catch (e) {}
  }
}
