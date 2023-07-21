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
  final bool isShowName;
  final bool showSecondaryButton;
  final String? secondaryLabel;
  final IconData? secondaryIcon;
  final VoidCallback? secondaryButtonOnClick;
  final VoidCallback? onListButtonClick;
  final VoidCallback? onEditButtonClick;
  final VoidCallback? onDeleteButtonClick;
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
    required this.isShowName,
    this.showSecondaryButton = false,
    this.secondaryLabel,
    this.secondaryIcon,
    this.secondaryButtonOnClick,
    this.onListButtonClick,
    this.onEditButtonClick,
    this.onDeleteButtonClick,
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
                isShowName ? '$title - $name' : '$title Details',
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
                  showSecondaryButton: showSecondaryButton,
                  secondaryButtonOnClick: secondaryButtonOnClick,
                  secondaryIcon: secondaryIcon,
                  secondaryLabel: secondaryLabel,
                  onListButtonClick: onListButtonClick,
                  onEditButtonClick: onEditButtonClick,
                  onDeleteButtonClick: onDeleteButtonClick,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
