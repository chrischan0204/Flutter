part of 'pagination_bloc.dart';

abstract class PaginationEvent extends Equatable {
  const PaginationEvent();

  @override
  List<Object> get props => [];
}

/// event to change row count per page
class PaginationRowsPerPageChanged extends PaginationEvent {
  final int rowsPerPage;
  const PaginationRowsPerPageChanged({
    required this.rowsPerPage,
  });

  @override
  List<Object> get props => [rowsPerPage];
}

/// event to change page number
class PaginationSelectedPageNumChanged extends PaginationEvent {
  final int selectedPageNum;
  const PaginationSelectedPageNumChanged({
    required this.selectedPageNum,
  });

  @override
  List<Object> get props => [selectedPageNum];
}

/// event to init status
class PaginationInit extends PaginationEvent {}
