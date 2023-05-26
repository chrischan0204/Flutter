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
        pagesVisible: MediaQuery.of(context).size.width < 1400 ? 5 : 10,
        spacing: 6,
        onPageChanged: (page) {
          widget.onPageChange(page);
        },
        activeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        activeBtnStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          )),
        ),
        inactiveBtnStyle: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          // shape: MaterialStateProperty.all(RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(3),
          //   side: const BorderSide(
          //     color: Colors.blueAccent,
          //     width: 1,
          //   ),
          // )),
        ),
        inactiveTextStyle: TextStyle(
          fontSize: 14,
          color: primaryColor,
        ),
      ),
    );
  }
}
