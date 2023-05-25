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
    return BlocConsumer<PaginationBloc, PaginationState>(
      listener: (context, state) => controller.currentPage = 0,
      listenWhen: (previous, current) =>
          previous.selectedPageNum != current.selectedPageNum &&
          current.selectedPageNum == 1,
      builder: (context, state) => CustomPagination(
        numOfPages: widget.numberPages,
        selectedPage: state.selectedPageNum,
        pagesVisible: 10,
        spacing: 10,
        onPageChanged: (page) {
          widget.onPageChange(page);
        },
        nextIcon: const Icon(
          Icons.chevron_right_rounded,
          color: Colors.blueAccent,
          size: 20,
        ),
        previousIcon: const Icon(
          Icons.chevron_left_rounded,
          color: Colors.blueAccent,
          size: 20,
        ),
        activeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        activeBtnStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: const BorderSide(
              color: Colors.blueAccent,
              width: 1,
            ),
          )),
        ),
        inactiveBtnStyle: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: const BorderSide(
              color: Colors.blueAccent,
              width: 1,
            ),
          )),
        ),
        inactiveTextStyle: const TextStyle(
          fontSize: 14,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
