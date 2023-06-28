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
  final bool isDeletable;
  final bool isEditable;
  const HeaderView({
    super.key,
    required this.title,
    required this.name,
    required this.label,
    required this.deleting,
    required this.deletable,
    required this.descriptionForDelete,
    required this.deleteEntity,
    required this.isDeletable,
    required this.isEditable,
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
              child: Container(
                alignment: Alignment.centerRight,
                child: CrudButtonsView(
                  label: label,
                  deletable: deletable,
                  deleting: deleting,
                  descriptionForDelete: descriptionForDelete,
                  deleteEntity: deleteEntity,
                  isDeletable: isDeletable,
                  isEditable: isEditable,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
