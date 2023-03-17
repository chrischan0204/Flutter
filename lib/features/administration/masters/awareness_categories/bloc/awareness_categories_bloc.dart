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
}
