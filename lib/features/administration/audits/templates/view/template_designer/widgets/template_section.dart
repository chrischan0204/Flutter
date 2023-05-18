import '/common_libraries.dart';

class TemplateSectionView extends StatefulWidget {
  const TemplateSectionView({super.key});

  @override
  State<TemplateSectionView> createState() => _TemplateSectionViewState();
}

class _TemplateSectionViewState extends State<TemplateSectionView> {
  TextEditingController sectionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Template Sections',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const CustomDivider(height: 30),
        Card(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Add new section',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const CustomDivider(),
                CustomTextFieldWithIcon(
                  hintText: 'Add new section',
                  suffixWidget: const Text('Add'),
                  onSuffixClicked: () {},
                  onChange: (value) {},
                  controller: sectionController,
                ),
                const CustomDivider(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Existing template sections',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  // child: ListView.separated(
                  //   itemCount: 10,
                  //   shrinkWrap: true,
                  //   separatorBuilder: (context, index) {
                  //     return const CustomDivider(height: 3);
                  //   },
                  //   itemBuilder: (context, index) {

                  //   },
                  // ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: const [
                                Text('data',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.blue)),
                                Text(' - (3 question)',
                                    style: TextStyle(fontSize: 11))
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
