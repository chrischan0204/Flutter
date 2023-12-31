import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:strings/strings.dart';

import '/common_libraries.dart';

class DeleteButton extends StatelessWidget {
  final String label;
  final bool deleting;
  final bool deletable;
  final String descriptionForDelete;
  final VoidCallback deleteEntity;
  final VoidCallback? onDeleteButtonClick;
  const DeleteButton({
    super.key,
    required this.label,
    required this.deleting,
    required this.deletable,
    required this.descriptionForDelete,
    required this.deleteEntity,
    this.onDeleteButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return deleting
        ? CustomButton(
            backgroundColor: const Color(0xffef4444),
            hoverBackgroundColor: const Color(0xffd73d3d),
            disabled: true,
            body: LoadingAnimationWidget.dotsTriangle(
              color: Colors.white,
              size: 22,
            ),
          )
        : Tooltip(
            message: width > minDesktopWidth ? '' : 'Delete ${camelize(label)}',
            child: CustomButton(
              backgroundColor: const Color(0xffef4444),
              hoverBackgroundColor: const Color(0xffd73d3d),
              iconData: PhosphorIcons.regular.trash,
              text: 'Delete ${camelize(label)}',
              isOnlyIcon: width < minDesktopWidth,
              onClick: onDeleteButtonClick ??
                  () {
                    if (deletable) {
                      CustomAlert(
                        context: context,
                        title: 'Confirm',
                        width: MediaQuery.of(context).size.width / 4,
                        description:
                            'Do you really want to delete this $label?',
                        btnOkText: 'Delete',
                        btnOkOnPress: () => deleteEntity(),
                        btnCancelOnPress: () {},
                        dialogType: DialogType.question,
                      ).show();
                    } else {
                      CustomAlert(
                        context: context,
                        width: MediaQuery.of(context).size.width / 4.5,
                        description: descriptionForDelete,
                        btnOkText: 'OK',
                        btnOkOnPress: () {},
                        dialogType: DialogType.warning,
                      ).show();
                    }
                  },
            ),
          );
  }
}
