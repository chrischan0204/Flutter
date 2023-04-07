import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '/data/model/model.dart';

part 'awareness_categories_event.dart';
part 'awareness_categories_state.dart';

class AwarenessCategoriesBloc
    extends Bloc<AwarenessCategoriesEvent, AwarenessCategoriesState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  final AwarenessGroupsRepository awarenessGroupsRepository;

  final String addErrorMessage =
      'There was an error while adding awareness category. Our team has been notified. Please wait a few minutes and try again.';
  final String editErrorMessage =
      'There was an error while editing awareness category. Our team has been notified. Please wait a few minutes and try again.';
  final String deleteErrorMessage =
      'There was an error while deleting awareness category. Our team has been notified. Please wait a few minutes and try again.';

  AwarenessCategoriesBloc({
    required this.awarenessCategoriesRepository,
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessCategoriesState()) {
    _triggerEvents();
  }

  // trigger the event
  void _triggerEvents() {
    on<AwarenessCategoriesRetrieved>(_onAwarenessCategoriesRetrieved);
    on<AwarenessGroupsForAwarenessCategoriesRetrieved>(
        _onAwarenessGroupsForAwarenessCategoriesRetrieved);
    on<AwarenessCategorySelected>(_onAwarenessCategorySelected);
    on<AwarenessCategorySelectedById>(_onAwarenessCategorySelectedById);
    on<AwarenessCategoryAdded>(_onAwarenessCategoryAdded);
    on<AwarenessCategoryEdited>(_onAwarenessCategoryEdited);
    on<AwarenessCategoryDeleted>(_onAwarenessCategoryDeleted);
    on<AwarenessCategoriesStatusInited>(_onAwarenessCategoriesStatusInited);
  }

  // get awareness groups list
  void _onAwarenessGroupsForAwarenessCategoriesRetrieved(
      AwarenessGroupsForAwarenessCategoriesRetrieved event,
      Emitter<AwarenessCategoriesState> emit) async {
    emit(
      state.copyWith(
        awarenessGroupsRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<AwarenessGroup> awarenessGroups =
          await awarenessGroupsRepository.getAwarenessGroups();
      emit(
        state.copyWith(
          awarenessGroupsRetrievedStatus: EntityStatus.success,
          awarenessGroups: awarenessGroups,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          awarenessGroupsRetrievedStatus: EntityStatus.failure,
        ),
      );
    }
  }

  // get awareness categories list
  Future<void> _onAwarenessCategoriesRetrieved(
      AwarenessCategoriesRetrieved event,
      Emitter<AwarenessCategoriesState> emit) async {
    emit(
      state.copyWith(
        awarenessCategoriesRetrievedStatus: EntityStatus.loading,
      ),
    );
    try {
      List<AwarenessCategory> awarenessCategories =
          await awarenessCategoriesRepository.getAwarenessCategories();
      emit(
        state.copyWith(
          awarenessCategoriesRetrievedStatus: EntityStatus.success,
          awarenessCategories: awarenessCategories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          awarenessCategoriesRetrievedStatus: EntityStatus.failure,
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

  // add awareness category
  Future<void> _onAwarenessCategoryAdded(
    AwarenessCategoryAdded event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategoryCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .addAwarenessCategory(event.awarenessCategory);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessCategoryCrudStatus: EntityStatus.success,
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
        message: addErrorMessage,
      ));
    }
  }

  // edit awareness category
  Future<void> _onAwarenessCategoryEdited(
    AwarenessCategoryEdited event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategoryCrudStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .editAwarenessCategory(event.awarenessCategory);
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
        message: editErrorMessage,
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
        awarenessCategoriesRetrievedStatus: EntityStatus.initial,
        awarenessCategoryCrudStatus: EntityStatus.initial,
      ),
    );
  }
}
