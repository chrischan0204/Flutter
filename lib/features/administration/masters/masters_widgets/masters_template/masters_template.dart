import 'package:flutter/material.dart';

import '/data/bloc/bloc.dart';
import '/global_widgets/global_widget.dart';
import '/data/model/entity.dart';
import '../../../../theme/view/widgets/sidebar/sidebar_style.dart';
import 'widgets/widgets.dart';

class MastersTemplate extends StatefulWidget {
  final List<Entity> entities;
  final String title;
  final String description;
  final String label;
  final String note;
  final List<CrudItem> crudItems;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  final VoidCallback deleteEntity;
  final ValueChanged<Entity> onRowClick;
  final String notifyContent;
  final NotifyType notifyType;
  final bool deletable;
  final bool isDeactive;
  final ValueChanged<bool> onActiveChanged;
  const MastersTemplate({
    super.key,
    this.entities = const [],
    required this.description,
    required this.title,
    required this.label,
    required this.note,
    this.crudItems = const [],
    required this.addEntity,
    required this.editEntity,
    required this.deleteEntity,
    required this.onRowClick,
    this.notifyContent = '',
    this.notifyType = NotifyType.initial,
    this.deletable = false,
    this.isDeactive = true,
    required this.onActiveChanged,
  });

  @override
  State<MastersTemplate> createState() => _CrudState();
}

class _CrudState extends State<MastersTemplate> {
  @override
  void initState() {
    super.initState();
    context.read<MastersTemplateBloc>().add(
          const MastersTemplateCrudTypeChanged(
            crudType: CrudType.add,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MastersTemplateBloc, MastersTemplateState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Notify(
              content: widget.notifyContent,
              type: widget.notifyType,
            ),
            PageTitle(
              title: widget.title,
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Description(
                          description: widget.description,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: sidebarColor,
                              ),
                            ),
                          ),
                          child: DataTableView(
                            entities: widget.entities,
                            onRowClick: widget.onRowClick,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 5 / 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: CrudView(
                      crudType: state.crudType,
                      label: widget.label,
                      note: widget.note,
                      crudItems: widget.crudItems,
                      deletable: widget.deletable,
                      addEntity: widget.addEntity,
                      editEntity: widget.editEntity,
                      deleteEntity: widget.deleteEntity,
                      isDeactive: widget.isDeactive,
                      onActiveChanged: (value) => widget.onActiveChanged(value),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
