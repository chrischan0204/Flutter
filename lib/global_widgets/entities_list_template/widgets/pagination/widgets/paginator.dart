import 'package:number_paginator/number_paginator.dart';

import '/common_libraries.dart';

class Paginator extends StatefulWidget {
  final ValueChanged<int> onPageChange;
  final int numberPages;
  const Paginator({
    super.key,
    required this.onPageChange,
    required this.numberPages,
  });

  @override
  State<Paginator> createState() => _PaginatorState();
}

class _PaginatorState extends State<Paginator> {
  NumberPaginatorController controller = NumberPaginatorController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<PaginationBloc, PaginationState>(
      listener: (context, state) => controller.currentPage = 0,
      listenWhen: (previous, current) =>
          previous.selectedPageNum != current.selectedPageNum &&
          current.selectedPageNum == 1,
      child: NumberPaginator(
        controller: controller,
        numberPages: widget.numberPages,
        config: NumberPaginatorUIConfig(
          buttonShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        onPageChange: (int index) {
          widget.onPageChange(index + 1);
        },
      ),
    );
  }
}
