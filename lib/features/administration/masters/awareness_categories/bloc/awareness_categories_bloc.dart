import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '/data/repository/repository.dart';
import '/data/model/entity.dart';
import '../data/model/awareness_category.dart';

part 'awareness_categories_event.dart';
part 'awareness_categories_state.dart';

class AwarenessCategoriesBloc
    extends Bloc<AwarenessCategoriesEvent, AwarenessCategoriesState> {
  final AwarenessCategoriesRepository awarenessCategoriesRepository;
  AwarenessCategoriesBloc({
    required this.awarenessCategoriesRepository,
  }) : super(const AwarenessCategoriesState()) {
    on<AwarenessCategoriesRetrieved>(_onAwarenessCategoriesRetrieved);
    on<AwarenessCategorySelected>(_onAwarenessCategorySelected);
    on<AwarenessCategorySelectedById>(_onAwarenessCategorySelectedById);
    on<AwarenessCategoryAdded>(_onAwarenessCategoryAdded);
    on<AwarenessCategoryEdited>(_onAwarenessCategoryEdited);
    on<AwarenessCategoryDeleted>(_onAwarenessCategoryDeleted);
    on<AwarenessCategoriesStatusInited>(_onAwarenessCategoriesStatusInited);
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
          awarenessCategoriesRetrievedStatus: EntityStatus.succuess,
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
      awarenessCategorySelectedStatus: EntityStatus.succuess,
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
          awarenessCategorySelectedStatus: EntityStatus.succuess,
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
      awarenessCategoryAddedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .addAwarenessCategory(event.awarenessCategory);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessCategoryAddedStatus: EntityStatus.succuess,
        ));
      } else {
        emit(state.copyWith(
          awarenessCategoryAddedStatus: EntityStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryAddedStatus: EntityStatus.failure,
      ));
    }
  }

  Future<void> _onAwarenessCategoryEdited(
    AwarenessCategoryEdited event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategoryEditedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .editAwarenessCategory(event.awarenessCategory);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessCategoryEditedStatus: EntityStatus.succuess,
          selectedAwarenessCategory: null,
        ));
      } else {
        emit(state.copyWith(
          awarenessCategoryEditedStatus: EntityStatus.failure,
          selectedAwarenessCategory: null,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryEditedStatus: EntityStatus.failure,
        selectedAwarenessCategory: null,
      ));
    }
  }

  Future<void> _onAwarenessCategoryDeleted(
    AwarenessCategoryDeleted event,
    Emitter<AwarenessCategoriesState> emit,
  ) async {
    emit(state.copyWith(
      awarenessCategoryDeletedStatus: EntityStatus.loading,
    ));
    try {
      EntityResponse response = await awarenessCategoriesRepository
          .deleteAwarenessCategory(event.awarenessCategoryId);
      if (response.isSuccess) {
        emit(state.copyWith(
          awarenessCategoryDeletedStatus: EntityStatus.succuess,
          selectedAwarenessCategory: null,
        ));
      } else {
        emit(state.copyWith(
            awarenessCategoryDeletedStatus: EntityStatus.failure,
            selectedAwarenessCategory: null));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryDeletedStatus: EntityStatus.failure,
        selectedAwarenessCategory: null,
      ));
    }
  }

  void _onAwarenessCategoriesStatusInited(
      AwarenessCategoriesStatusInited event, Emitter<AwarenessCategoriesState> emit) {
    emit(
      state.copyWith(
        awarenessCategoryAddedStatus: EntityStatus.initial,
        awarenessCategoryEditedStatus: EntityStatus.initial,
        awarenessCategorySelectedStatus: EntityStatus.initial,
        awarenessCategoryDeletedStatus: EntityStatus.initial,
        awarenessCategoriesRetrievedStatus: EntityStatus.initial,
      ),
    );
  }
}
