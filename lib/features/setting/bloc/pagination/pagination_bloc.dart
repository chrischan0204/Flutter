import 'package:equatable/equatable.dart';
import '/common_libraries.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc() : super(const PaginationState()) {
    on<PaginationRowsPerPageChanged>(_onPaginationRowsPerPageChanged);
    on<PaginationSelectedPageNumChanged>(_onPaginationSelectedPageNumChanged);
    on<PaginationInit>(_onPaginationInit);
  }

  void _onPaginationInit(
    PaginationInit event,
    Emitter<PaginationState> emit,
  ) {
    emit(const PaginationState());
  }

  void _onPaginationRowsPerPageChanged(
    PaginationRowsPerPageChanged event,
    Emitter<PaginationState> emit,
  ) {
    emit(state.copyWith(rowsPerPage: event.rowsPerPage));
  }

  void _onPaginationSelectedPageNumChanged(
    PaginationSelectedPageNumChanged event,
    Emitter<PaginationState> emit,
  ) {
    emit(state.copyWith(selectedPageNum: event.selectedPageNum));
  }
}
