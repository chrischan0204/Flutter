import '/common_libraries.dart';

class AssestsView extends StatelessWidget {
  const AssestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset20,
            child: Text(
              'Assets',
              style: textSemiBold16,
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset12,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Document',
                    style: textNormal12,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Download',
                    style: textNormal12,
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    'Delete',
                    style: textNormal12,
                  ),
                ),
              ],
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset12,
            child: AssetsListItemView(
              active: true,
              title: 'slippery_staircase (image)',
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset12,
            child: AssetsListItemView(
              title: 'Specs on cleaning (word)',
            ),
          ),
          CustomBottomBorderContainer(
            padding: inset12,
            child: AssetsListItemView(
              title: 'Specs on maintenance (pdf)',
            ),
          )
        ],
      ),
    );
  }
}

class AssetsListItemView extends StatelessWidget {
  final String title;
  final bool active;
  const AssetsListItemView({
    super.key,
    required this.title,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: textNormal12.copyWith(color: active ? primaryColor : null),
          ),
        ),
        SizedBox(
          width: 100,
          child: Icon(
            PhosphorIcons.regular.downloadSimple,
            color: purpleColor,
            size: 16,
          ),
        ),
        SizedBox(
          width: 100,
          child: Icon(
            PhosphorIcons.regular.trashSimple,
            color: Colors.red,
            size: 16,
          ),
        ),
      ],
    );
  }
}
