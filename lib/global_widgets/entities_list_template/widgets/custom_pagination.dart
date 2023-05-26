import '/common_libraries.dart';
import 'package:star_menu/star_menu.dart';

class CustomPagination extends StatelessWidget {
  const CustomPagination({
    super.key,

    /// Total number of pages
    required this.numOfPages,

    /// Current selected page
    required this.selectedPage,

    /// Number of pages visible in the widget between the previous and next buttons
    required this.pagesVisible,

    /// Callback function when a page is selected
    required this.onPageChanged,

    /// Style for the active page text
    required this.activeTextStyle,

    /// Style for the active page button
    required this.activeBtnStyle,

    /// Style for the inactive page text
    required this.inactiveTextStyle,

    /// Style for the inactive page button
    required this.inactiveBtnStyle,

    /// Icon for the previous button
    this.previousIcon,

    /// Icon for the next button
    this.nextIcon,

    /// Spacing between the individual page buttons
    this.spacing,
  });

  final int numOfPages;
  final int selectedPage;
  final int pagesVisible;
  final Function onPageChanged;
  final TextStyle activeTextStyle;
  final ButtonStyle activeBtnStyle;
  final TextStyle inactiveTextStyle;
  final ButtonStyle inactiveBtnStyle;
  final Icon? previousIcon;
  final Icon? nextIcon;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(width: spacing ?? 0);

    int middle = (pagesVisible - 1) ~/ 2;

    final List<Widget> buttons = [];
    if (numOfPages <= pagesVisible) {
      for (int i = 1; i <= numOfPages; i++) {
        buttons.add(PaginationButton(
          key: ValueKey(i),
          index: i,
          selectedIndex: selectedPage,
          onPageChanged: () => onPageChanged(i),
          activeBtnStyle: activeBtnStyle,
          inactiveBtnStyle: inactiveBtnStyle,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
        ));
        if (i != numOfPages) {
          buttons.add(space);
        }
      }
    } else if (selectedPage <= middle || selectedPage >= numOfPages - middle) {
      for (int i = 1; i <= middle + 1; i++) {
        buttons.add(PaginationButton(
          key: ValueKey(i),
          index: i,
          selectedIndex: selectedPage,
          onPageChanged: () => onPageChanged(i),
          activeBtnStyle: activeBtnStyle,
          inactiveBtnStyle: inactiveBtnStyle,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
        ));
        buttons.add(space);
      }

      if (middle + 2 < numOfPages - middle - 1) {
        buttons.add(MoreButton(
          start: middle + 2,
          end: numOfPages - middle - 1,
          onChange: (value) => onPageChanged(value),
        ));
        buttons.add(space);
      }

      for (int i = numOfPages - middle; i <= numOfPages; i++) {
        buttons.add(PaginationButton(
          index: i,
          selectedIndex: selectedPage,
          onPageChanged: () => onPageChanged(i),
          activeBtnStyle: activeBtnStyle,
          inactiveBtnStyle: inactiveBtnStyle,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
        ));
        if (i != numOfPages) {
          buttons.add(space);
        }
      }
    } else {
      buttons.add(PaginationButton(
        index: 1,
        selectedIndex: selectedPage,
        onPageChanged: () => onPageChanged(1),
        activeBtnStyle: activeBtnStyle,
        inactiveBtnStyle: inactiveBtnStyle,
        activeTextStyle: activeTextStyle,
        inactiveTextStyle: inactiveTextStyle,
      ));
      buttons.add(space);

      buttons.add(MoreButton(
        start: 2,
        end: selectedPage - middle + 1,
        onChange: (value) => onPageChanged(value),
      ));

      buttons.add(space);
      for (int i = selectedPage - middle + 2;
          i <= selectedPage + middle - 1;
          i++) {
        buttons.add(PaginationButton(
          index: i,
          selectedIndex: selectedPage,
          onPageChanged: () => onPageChanged(i),
          activeBtnStyle: activeBtnStyle,
          inactiveBtnStyle: inactiveBtnStyle,
          activeTextStyle: activeTextStyle,
          inactiveTextStyle: inactiveTextStyle,
        ));
        buttons.add(space);
      }

      buttons.add(MoreButton(
        start: selectedPage + middle,
        end: numOfPages - 1,
        onChange: (value) => onPageChanged(value),
      ));

      buttons.add(space);

      buttons.add(PaginationButton(
        index: numOfPages,
        selectedIndex: selectedPage,
        onPageChanged: () => onPageChanged(numOfPages),
        activeBtnStyle: activeBtnStyle,
        inactiveBtnStyle: inactiveBtnStyle,
        activeTextStyle: activeTextStyle,
        inactiveTextStyle: inactiveTextStyle,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Previous button
        IconButton(
          color: primaryColor,
          icon: previousIcon ??
              const Icon(
                PhosphorIcons.arrowFatLinesLeft,
                size: 16,
              ),
          onPressed: selectedPage > 1 ? () => onPageChanged(1) : null,
        ),

        // ElevatedButton(
        //   onPressed: () {},
        //   child: Icon(Icons.menu, color: Colors.white),
        //   style: ElevatedButton.styleFrom(
        //     shape: CircleBorder(),
        //     padding: EdgeInsets.all(20),
        //     backgroundColor: Colors.blue, // <-- Button color
        //     foregroundColor: Colors.red, // <-- Splash color
        //   ),
        // ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: Icon(Icons.menu),
        //   style: ButtonStyle(
        //     shape: MaterialStateProperty.all(CircleBorder()),
        //     padding: MaterialStateProperty.all(EdgeInsets.all(20)),
        //     backgroundColor:
        //         MaterialStateProperty.all(Colors.blue), // <-- Button color
        //     overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        //       if (states.contains(MaterialState.pressed))
        //         return Colors.red; // <-- Splash color
        //     }),
        //   ),
        // ),
        IconButton(
          color: primaryColor,
          icon: previousIcon ??
              const Icon(
                PhosphorIcons.arrowFatLineLeft,
                size: 16,
              ),
          onPressed:
              selectedPage > 1 ? () => onPageChanged(selectedPage - 1) : null,
        ),
        space,
        ...buttons,
        space,

        /// Next button
        IconButton(
          color: primaryColor,
          icon: nextIcon ??
              const Icon(
                PhosphorIcons.arrowFatLineRight,
                size: 16,
              ),
          onPressed: selectedPage < numOfPages
              ? () => onPageChanged(selectedPage + 1)
              : null,
        ),
        IconButton(
          color: primaryColor,
          icon: nextIcon ??
              const Icon(
                PhosphorIcons.arrowFatLinesRight,
                size: 16,
              ),
          onPressed: selectedPage < numOfPages
              ? () => onPageChanged(numOfPages)
              : null,
        ),
      ],
    );
  }
}

class PaginationButton extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final VoidCallback onPageChanged;
  final ButtonStyle activeBtnStyle;
  final ButtonStyle inactiveBtnStyle;
  final TextStyle activeTextStyle;
  final TextStyle inactiveTextStyle;
  const PaginationButton({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onPageChanged,
    required this.activeBtnStyle,
    required this.inactiveBtnStyle,
    required this.activeTextStyle,
    required this.inactiveTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      child: TextButton(
        style: index == selectedIndex ? activeBtnStyle : inactiveBtnStyle,
        onPressed: () => onPageChanged(),
        child: Text(
          '$index',
          style: index == selectedIndex ? activeTextStyle : inactiveTextStyle,
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  final int start;
  final int end;
  final ValueChanged<int> onChange;
  const MoreButton({
    super.key,
    required this.start,
    required this.end,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return StarMenu(
      params: StarMenuParameters.dropdown(context)
          .copyWith(centerOffset: const Offset(0, -80)),
      items: [
        Container(
          constraints: const BoxConstraints(maxHeight: 200),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = start; i <= end; i++)
                  InkWell(
                    onTap: () => onChange(i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 8,
                      ),
                      child: Text(
                        i.toString(),
                        style: TextStyle(fontSize: 14, color: primaryColor),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
      child: Icon(
        PhosphorIcons.dotsThree,
        color: primaryColor,
      ),
    );
  }
}
