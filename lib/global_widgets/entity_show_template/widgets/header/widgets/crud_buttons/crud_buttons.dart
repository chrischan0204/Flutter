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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GoToListButton(label: label),
        const SizedBox(
          width: 15,
        ),
        GoToEditButton(label: label),
        const SizedBox(
          width: 15,
        ),
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
