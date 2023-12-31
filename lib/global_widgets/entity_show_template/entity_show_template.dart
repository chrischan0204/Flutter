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
  final bool isDeletable;
  final bool isEditable;
  final bool isShowName;
  final bool showSecondaryButton;
  final String? secondaryLabel;
  final IconData? secondaryIcon;
  final VoidCallback? secondaryButtonOnClick;
  final bool isScrollView;
  final VoidCallback? onListButtonClick;
  final VoidCallback? onEditButtonClick;
  final VoidCallback? onDeleteButtonClick;

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
    this.isDeletable = true,
    this.isEditable = true,
    this.isShowName = true,
    this.showSecondaryButton = false,
    this.secondaryLabel,
    this.secondaryIcon,
    this.secondaryButtonOnClick,
    this.isScrollView = true,
    this.onListButtonClick,
    this.onEditButtonClick,
    this.onDeleteButtonClick,
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
              isDeletable: widget.isDeletable,
              isEditable: widget.isEditable,
              isShowName: widget.isShowName,
              showSecondaryButton: widget.showSecondaryButton,
              secondaryButtonOnClick: widget.secondaryButtonOnClick,
              secondaryIcon: widget.secondaryIcon,
              secondaryLabel: widget.secondaryLabel,
              onListButtonClick: widget.onListButtonClick,
              onEditButtonClick: widget.onEditButtonClick,
              onDeleteButtonClick: widget.onDeleteButtonClick,
            ),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: widget.isScrollView
                      ? CustomScrollViewWithBackButton(
                          child: widget.tabItems.isNotEmpty
                              ? _buildTab()
                              : _buildEntityDetails(),
                        )
                      : widget.tabItems.isNotEmpty
                          ? _buildTab()
                          : _buildEntityDetails(),
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
      onTabClick: (current, previous) async {
        return true;
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
