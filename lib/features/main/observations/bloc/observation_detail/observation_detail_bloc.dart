import '/common_libraries.dart';

part 'observation_detail_event.dart';
part 'observation_detail_state.dart';

class ObservationDetailBloc
    extends Bloc<ObservationDetailEvent, ObservationDetailState> {
  final BuildContext context;
  late ObservationsRepository observationsRepository;
  late SitesRepository sitesRepository;
  late ProjectsRepository projectsRepository;
  late PriorityLevelsRepository priorityLevelsRepository;
  late AwarenessCategoriesRepository awarenessCategoriesRepository;
  late CompaniesRepository companiesRepository;
  late ObservationTypesRepository observationTypesRepository;
  ObservationDetailBloc(this.context) : super(const ObservationDetailState()) {
    observationsRepository = RepositoryProvider.of(context);
    sitesRepository = RepositoryProvider.of(context);
    projectsRepository = RepositoryProvider.of(context);
    observationTypesRepository = RepositoryProvider.of(context);
    priorityLevelsRepository = RepositoryProvider.of(context);
    awarenessCategoriesRepository = RepositoryProvider.of(context);
    companiesRepository = RepositoryProvider.of(context);

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
    on<ObservationDetailObservationCategoryListLoaded>(
        _onObservationDetailObservationCategoryListLoaded);
    on<ObservationDetailPriorityLevelListLoaded>(
        _onObservationDetailPriorityLevelListLoaded);
  }

  Future<void> _onObservationDetailLoaded(
    ObservationDetailLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    try {
      Observation observation =
          await observationsRepository.getObservationById(event.observationId);

      emit(state.copyWith(observation: observation));
    } catch (e) {}
  }

  Future<void> _onObservationDetailObservationDeleted(
    ObservationDetailObservationDeleted event,
    Emitter<ObservationDetailState> emit,
  ) async {}

  Future<void> _onObservationDetailObservationCategoryListLoaded(
    ObservationDetailObservationCategoryListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<AwarenessCategory> awarenessCategoryList =
        await awarenessCategoriesRepository.getAwarenessCategorieList();

    emit(state.copyWith(awarenessCategoryList: awarenessCategoryList));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailSiteListLoaded(
    ObservationDetailSiteListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Site> siteList = await sitesRepository.getSiteList();

    emit(state.copyWith(siteList: siteList));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailCompanyListLoaded(
    ObservationDetailCompanyListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Company> companyList = await companiesRepository.getCompanyList();

    emit(state.copyWith(companyList: companyList));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailProjectListLoaded(
    ObservationDetailProjectListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<Project> projectList = await projectsRepository.getProjectList();

    emit(state.copyWith(projectList: projectList));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailPriorityLevelListLoaded(
    ObservationDetailPriorityLevelListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<PriorityLevel> priorityLevelList =
        await priorityLevelsRepository.getPriorityLevelList();

    emit(state.copyWith(priorityLevelList: priorityLevelList));
    try {} catch (e) {}
  }

  Future<void> _onObservationDetailObservationTypeListLoaded(
    ObservationDetailObservationTypeListLoaded event,
    Emitter<ObservationDetailState> emit,
  ) async {
    List<ObservationType> observationTypeList =
        await observationTypesRepository.getObservationTypeList();

    emit(state.copyWith(observationTypeList: observationTypeList));
    try {} catch (e) {}
  }
}
