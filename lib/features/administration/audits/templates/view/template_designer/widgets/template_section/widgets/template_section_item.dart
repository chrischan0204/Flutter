import '/common_libraries.dart';

class TemplateSectionItem extends StatelessWidget {
  final String sectionName;
  final int templateSectionItemCount;
  const TemplateSectionItem({
    super.key,
    required this.sectionName,
    required this.templateSectionItemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(sectionName,
                      style: const TextStyle(fontSize: 14, color: Colors.blue)),
                  Text(' - ($templateSectionItemCount question)',
                      style: const TextStyle(fontSize: 11))
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  PhosphorIcons.caretCircleDoubleRight,
                  size: 18,
                  color: warnColor,
                ),
              ),
            ],
          ),
        ),
        const CustomDivider(height: 3)
      ],
    );
  }
}
