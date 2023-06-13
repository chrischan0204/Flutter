import '/common_libraries.dart';

class EntityShowTemplate extends StatefulWidget {
  final String title;
  final String label;
  final Map<String, Widget> tabItems;
  final Widget? customDetailWidget;
  final VoidCallback deleteEntity;
  final EntityStatus crudStatus;
  final bool deletable;
  final Entity? entity;
  final String descriptionForDelete;

  const EntityShowTemplate({
    super.key,
    required this.title,
    required this.label,
    this.tabItems = const <String, Widget>{},
    this.customDetailWidget,
    required this.deleteEntity,
    this.crudStatus = EntityStatus.initial,
    this.deletable = true,
    this.entity,
    this.descriptionForDelete = '',
  });

  @override
  State<EntityShowTemplate> createState() => _EntityShowTemplateState();
}

class _EntityShowTemplateState extends State<EntityShowTemplate> {
  late int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderView(
              title: widget.title,
              name: widget.entity?.name ?? "",
              label: widget.label,
              deleting: widget.crudStatus.isLoading,
              deletable: widget.deletable,
              descriptionForDelete: widget.descriptionForDelete,
              deleteEntity: widget.deleteEntity,
            ),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomScrollViewWithBackButton(
                    child: widget.tabItems.isNotEmpty
                        ? _buildTab()
                        : _buildEntityDetails(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab() {
    return CustomTabBar(
      activeIndex: selectedTabIndex,
      tabs: {'Details': _buildEntityDetails(), ...widget.tabItems},
      onTabClick: (index) {
        if (index == 0) {
          context
              .read<FormDirtyBloc>()
              .add(const FormDirtyChanged(isDirty: true));
        } else {
          context
              .read<FormDirtyBloc>()
              .add(const FormDirtyChanged(isDirty: false));
        }
      },
    );
  }

  Widget _buildEntityDetails() {
    return widget.customDetailWidget ??
        (widget.entity != null
            ? Builder(
                builder: (context) {
                  Map<String, dynamic> detailsMap =
                      widget.entity!.detailItemsToMap();
                  return Column(
                    children: [
                      for (final detail in detailsMap.entries)
                        ShowItem(
                          label: detail.key,
                          content: CustomDataCell(
                            data: detail.value,
                          ),
                        ),
                    ],
                  );
                },
              )
            : const Center(
                child: Loader(),
              ));
  }
}
