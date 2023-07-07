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
  final bool showSecondaryButton;
  final String? secondaryLabel;
  final IconData? secondaryIcon;
  final VoidCallback? secondaryButtonOnClick;
  const CrudButtonsView({
    super.key,
    required this.label,
    required this.deleting,
    required this.deletable,
    required this.descriptionForDelete,
    required this.deleteEntity,
    required this.isDeletable,
    required this.isEditable,
    this.showSecondaryButton = false,
    this.secondaryLabel,
    this.secondaryIcon,
    this.secondaryButtonOnClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GoToListButton(label: label),
        if (showSecondaryButton) spacerx15,
        if (showSecondaryButton)
          SecondaryButton(
            label: secondaryLabel!,
            icon: secondaryIcon!,
            onClick: secondaryButtonOnClick!,
          ),
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
