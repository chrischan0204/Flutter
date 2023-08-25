import '/common_libraries.dart';

part 'awareness_categories_event.dart';
part 'awareness_categories_state.dart';

class AwarenessCategoriesBloc
    extends Bloc<AwarenessCategoriesEvent, AwarenessCategoriesState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  final AwarenessGroupsRepository awarenessGroupsRepository;

  final String deleteErrorMessage = ErrorMessage('awareness category').delete;

  AwarenessCategoriesBloc({
    required this.awarenessCategoriesRepository,
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessCategoriesState()) {
    _triggerEvents();
  }

  // trigger the event
  void _triggerEvents() {
    on<AwarenessCategoriesLoaded>(_onAwarenessCategoriesLoaded);
    on<AwarenessGroupsForAwarenessCategoriesLoaded>(
        _onAwarenessGroupsForAwarenessCategoriesLoaded);
    on<AwarenessCategorySelected>(_onAwarenessCategorySelected);
    on<AwarenessCategorySelectedById>(_onAwarenessCategorySelectedById);
    on<AwarenessCategoryDeleted>(_onAwarenessCategoryDeleted);
    on<AwarenessCategoriesStatusInited>(_onAwarenessCategoriesStatusInited);
  }

  // get awareness groups list
  void _onAwarenessGroupsForAwarenessCategoriesLoaded(
      AwarenessGroupsForAwarenessCategoriesLoaded event,
      Emitter<AwarenessCategoriesState> emit) async {
    emit(
      state.copyWith(
        awarenessGroupsLoadedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<AwarenessGroup> awarenessGroups =
          await awarenessGroupsRepository.getAwarenessGroups();
      emit(
        state.copyWith(
          awarenessGroupsLoadedStatus: EntityStatus.success,
          awarenessGroups: awarenessGroups,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          awarenessGroupsLoadedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get awareness categories list
  Future<void> _onAwarenessCategoriesLoaded(AwarenessCategoriesLoaded event,
      Emitter<AwarenessCategoriesState> emit) async {
    emit(
      state.copyWith(
        awarenessCategoriesLoadedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<AwarenessCategory> awarenessCategories =
          await awarenessCategoriesRepository.getAwarenessCategorieList();
      emit(
        state.copyWith(
          awarenessCategoriesLoadedStatus: EntityStatus.success,
          awarenessCategories: awarenessCategories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          awarenessCategoriesLoadedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // select awareness category
  Future<void> _onAwarenessCategorySelected(
    AwarenessCategorySelected event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategorySelectedStatus: EntityStatus.success,
      selectedAwarenessCategory: event.awarenessCategory,
    ));
  }

  // get awareness category by id
  Future<void> _onAwarenessCategorySelectedById(
    AwarenessCategorySelectedById event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategorySelectedStatus: EntityStatus.loading,
      selectedAwarenessCategory: null,
    ));
    try {
      AwarenessCategory? selectedAwarenessCategory =
          await awarenessCategoriesRepository
              .getAwarenessCategoryById(event.awarenessCategoryId);
      emit(
        state.copyWith(
          selectedAwarenessCategory: selectedAwarenessCategory,
          awarenessCategorySelectedStatus: EntityStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        selectedAwarenessCategory: null,
        awarenessCategorySelectedStatus: EntityStatus.failure,
      ));
    }
  }

  // delete awareness category
  Future<void> _onAwarenessCategoryDeleted(
    AwarenessCategoryDeleted event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategoryCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .deleteAwarenessCategory(event.awarenessCategoryId);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessCategoryCrudStatus: EntityStatus.success,
          selectedAwarenessCategory: null,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          awarenessCategoryCrudStatus: EntityStatus.failure,
          message: response.message,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryCrudStatus: EntityStatus.failure,
        message: deleteErrorMessage,
      ));
    }
  }

  // init status of bloc
  void _onAwarenessCategoriesStatusInited(AwarenessCategoriesStatusInited event,
      Emitter<AwarenessCategoriesState> emit) {
    emit(
      state.copyWith(
        awarenessCategorySelectedStatus: EntityStatus.initial,
        awarenessCategoriesLoadedStatus: EntityStatus.initial,
        awarenessCategoryCrudStatus: EntityStatus.initial,
      ),
    );
  }
}
