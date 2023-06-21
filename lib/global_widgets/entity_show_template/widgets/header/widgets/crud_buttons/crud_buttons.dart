import '/common_libraries.dart';
import 'widgets/widgets.dart';

class CrudButtonsView extends StatelessWidget {
  final String label;
  final bool deletable;
  final bool deleting;
  final String descriptionForDelete;
  final VoidCallback deleteEntity;
  const CrudButtonsView({
    super.key,
    required this.label,
    required this.deleting,
    required this.deletable,
    required this.descriptionForDelete,
    required this.deleteEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoToListButton(label: label),
        spacerx15,
        GoToEditButton(label: label),
        spacerx15,
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
