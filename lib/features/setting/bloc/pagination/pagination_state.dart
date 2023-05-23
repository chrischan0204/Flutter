part of 'pagination_bloc.dart';

class PaginationState extends Equatable {
  final int selectedPageNum;
  final int rowsPerPage;
  const PaginationState({
    this.selectedPageNum = 1,
    this.rowsPerPage = initialRowsPerPage,
  });

  @override
  List<Object> get props => [
        selectedPageNum,
        rowsPerPage,
      ];

  PaginationState copyWith({
    int? selectedPageNum,
    int? rowsPerPage,
  }) {
    return PaginationState(
      selectedPageNum: selectedPageNum ?? this.selectedPageNum,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }
}
