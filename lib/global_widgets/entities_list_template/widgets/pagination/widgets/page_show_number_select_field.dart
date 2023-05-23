import '/common_libraries.dart';

class PageShowNumberSelectField extends StatefulWidget {
  final ValueChanged<int> onPageRowChange;
  final int selectedPageNum;
  final int totalRows;
  const PageShowNumberSelectField({
    super.key,
    required this.onPageRowChange,
    required this.selectedPageNum,
    required this.totalRows,
  });

  @override
  State<PageShowNumberSelectField> createState() =>
      _PageShowNumberSelectFieldState();
}

class _PageShowNumberSelectFieldState extends State<PageShowNumberSelectField> {
  int pagePerRow = initialRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomSingleSelect(
          width: 100,
          isSearchable: false,
          selectedValue: pagePerRow.toString(),
          items: const {
            '5': '5',
            '10': '10',
            '20': '20',
            '50': '50',
          },
          onChanged: (value) {
            setState(() => pagePerRow = int.parse(value.key));
            widget.onPageRowChange(pagePerRow);
          },
        ),
        const SizedBox(width: 50),
        Builder(builder: (context) {
          int start = pagePerRow * (widget.selectedPageNum - 1) + 1;
          int end = pagePerRow * widget.selectedPageNum;
          end = end > widget.totalRows ? widget.totalRows : end;
          return Text('Results: $start - $end of ${widget.totalRows}');
        }),
      ],
    );
  }
}
