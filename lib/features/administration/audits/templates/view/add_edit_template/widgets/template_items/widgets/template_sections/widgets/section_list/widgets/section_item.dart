import '/common_libraries.dart';

class SectionItemView extends StatefulWidget {
  final String section;
  final bool first;
  const SectionItemView({
    super.key,
    required this.section,
    this.first = false,
  });

  @override
  State<SectionItemView> createState() => _SectionItemViewState();
}

class _SectionItemViewState extends State<SectionItemView> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => setState(() => _hover = value),
      child: Container(
        color: _hover ? const Color(0xfff7fdf1) : Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!widget.first) const CustomDivider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.white,
                    child: Center(
                      child: Icon(
                        PhosphorIcons.regular.dotsThreeVertical,
                        size: 22,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.section,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
