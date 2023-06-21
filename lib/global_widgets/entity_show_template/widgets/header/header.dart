import '/common_libraries.dart';
import 'widgets/widgets.dart';

class HeaderView extends StatelessWidget {
  final String title;
  final String name;
  final String label;
  final bool deleting;
  final bool deletable;
  final String descriptionForDelete;
  final VoidCallback deleteEntity;
  const HeaderView({
    super.key,
    required this.title,
    required this.name,
    required this.label,
    required this.deleting,
    required this.deletable,
    required this.descriptionForDelete,
    required this.deleteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: insetx20y15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                '$title - $name',
                style: textSemiBold18,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                softWrap: false,
              ),
            ),
            spacerx15,
            Expanded(
              flex: 2,
              child: CrudButtonsView(
                label: label,
                deletable: deletable,
                deleting: deleting,
                descriptionForDelete: descriptionForDelete,
                deleteEntity: deleteEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
