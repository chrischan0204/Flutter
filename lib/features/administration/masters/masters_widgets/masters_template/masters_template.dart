import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  late double positionRight;
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
  void didChangeDependencies() {
    positionRight = -MediaQuery.of(context).size.width / 4;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MastersTemplateBloc, MastersTemplateState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
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
                Container(
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
                          onRowClick: (_) {
                            widget.onRowClick(_);
                            setState(() {
                              positionRight = 0;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            AnimatedPositioned(
              top: 0,
              right: positionRight,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 1000,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'North America',
                            style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                positionRight =
                                    -MediaQuery.of(context).size.width / 4;
                              });
                            },
                            icon: const Icon(
                              PhosphorIcons.arrowCircleRight,
                              size: 20,
                              color: Color(0xffef4444),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
