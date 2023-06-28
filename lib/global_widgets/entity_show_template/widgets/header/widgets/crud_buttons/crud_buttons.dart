import '/common_libraries.dart';
import 'widgets/widgets.dart';

class CrudButtonsView extends StatelessWidget {
  final String label;
  final bool deletable;
  final bool deleting;
  final String descriptionForDelete;
  final VoidCallback deleteEntity;
  final bool isDeletable;
  final bool isEditable;
  const CrudButtonsView({
    super.key,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoToListButton(label: label),
        if (isEditable) spacerx15,
        if (isEditable) GoToEditButton(label: label),
        if (isDeletable) spacerx15,
        if (isDeletable)
          DeleteButton(
            label: label,
            deletable: deletable,
            deleting: deleting,
            descriptionForDelete: descriptionForDelete,
            deleteEntity: deleteEntity,
          ),
      ],
    );
  }
}
