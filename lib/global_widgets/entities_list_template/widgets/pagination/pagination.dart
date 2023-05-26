import '/common_libraries.dart';
import 'widgets/widgets.dart';

class PaginationView extends StatefulWidget {
  final void Function(int selectedPageNum, int rowPerPage) onPaginate;
  final int totalRows;
  const PaginationView({
    super.key,
    required this.onPaginate,
    required this.totalRows,
  });

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  late PaginationBloc paginationBloc;

  @override
  void initState() {
    paginationBloc = context.read()..add(PaginationInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totalRows <= 0) {
      return Container();
    }
    return BlocBuilder<PaginationBloc, PaginationState>(
      builder: (context, state) {
        return Card(
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Paginator(
                  numberPages: (widget.totalRows / state.rowsPerPage).ceil(),
                  onPageChange: (value) {
                    paginationBloc.add(PaginationSelectedPageNumChanged(
                        selectedPageNum: value));
                    widget.onPaginate(value, state.rowsPerPage);
                  },
                ),
                PageShowNumberSelectField(
                  totalRows: widget.totalRows,
                  selectedPageNum: state.selectedPageNum,
                  onPageRowChange: (value) {
                    paginationBloc
                      ..add(PaginationRowsPerPageChanged(rowsPerPage: value))
                      ..add(const PaginationSelectedPageNumChanged(
                          selectedPageNum: 1));
                    widget.onPaginate(1, value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
