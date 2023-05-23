part of 'pagination_bloc.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object> get props => [];
}

class PaginationRowsPerPageChanged extends PaginationEvent {
  final int rowsPerPage;
  const PaginationRowsPerPageChanged({
    required this.rowsPerPage,
  });

  @override
  List<Object> get props => [rowsPerPage];
}

class PaginationSelectedPageNumChanged extends PaginationEvent {
  final int selectedPageNum;
  const PaginationSelectedPageNumChanged({
    required this.selectedPageNum,
  });

  @override
  List<Object> get props => [selectedPageNum];
}

class PaginationInit extends PaginationEvent {}
