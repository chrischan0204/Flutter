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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title - $name',
            style: TextStyle(
              color: darkTeal,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          CrudButtonsView(
            label: label,
            deletable: deletable,
            deleting: deleting,
            descriptionForDelete: descriptionForDelete,
            deleteEntity: deleteEntity,
          ),
        ],
      ),
    );
  }
}
