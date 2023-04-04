import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/model/model.dart';
import '/data/repository/repository.dart';
import '/data/model/model.dart';

part 'awareness_categories_event.dart';
part 'awareness_categories_state.dart';

class AwarenessCategoriesBloc
    extends Bloc<AwarenessCategoriesEvent, AwarenessCategoriesState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  final AwarenessGroupsRepository awarenessGroupsRepository;
  AwarenessCategoriesBloc({
    required this.awarenessCategoriesRepository,
    required this.awarenessGroupsRepository,
  }) : super(const AwarenessCategoriesState()) {
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

  void _onAwarenessGroupsForAwarenessCategoriesRetrieved(
      AwarenessGroupsForAwarenessCategoriesRetrieved event,
      Emitter<AwarenessCategoriesState> emit) async {
    emit(state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.loading));
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
          state.copyWith(awarenessGroupsRetrievedStatus: EntityStatus.failure));
    }
  }

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

  Future<void> _onAwarenessCategorySelected(
    AwarenessCategorySelected event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategorySelectedStatus: EntityStatus.success,
      selectedAwarenessCategory: event.awarenessCategory,
    ));
  }

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
        message:
            'There was an error while adding. Our team has been notified. Please wait a few minutes and try again.',
      ));
    }
  }

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
        message:
            'There was an error while editing awareness category. Our team has been notified. Please wait a few minutes and try again.',
      ));
    }
  }

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
          message:
              'There was an error while deleting. Our team has been notified. Please wait a few minutes and try again.'));
    }
  }

  void _onAwarenessCategoriesStatusInited(AwarenessCategoriesStatusInited event,
      Emitter<AwarenessCategoriesState> emit) {
    emit(
      state.copyWith(
        awarenessCategorySelectedStatus: EntityStatus.initial,
        awarenessCategoriesRetrievedStatus: EntityStatus.initial,
        awarenessCategoryCrudStatus: EntityStatus.initial,
        message: '',
      ),
    );
  }
}
