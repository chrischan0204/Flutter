import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:strings/strings.dart';

import '/global_widgets/global_widget.dart';
import 'widgets/widgets.dart';
import '/data/bloc/bloc.dart';

class CrudView extends StatefulWidget {
  final CrudType crudType;
  final String label;
  final String note;
  final List<CrudItem> crudItems;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  final VoidCallback deleteEntity;
  final bool deletable;
  final bool isActive;

  const CrudView({
    super.key,
    this.crudType = CrudType.add,
    required this.label,
    required this.note,
    required this.crudItems,
    required this.addEntity,
    required this.editEntity,
    required this.deleteEntity,
    required this.deletable,
    required this.isActive,
  });

  @override
  State<CrudView> createState() => _CrudViewState();
}

class _CrudViewState extends State<CrudView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CrudTitle(
          label: widget.label,
          type: widget.crudType == CrudType.editOrDelete
              ? 'Edit/Remove'
              : 'Add new',
        ),
        const CustomDivider(),
        ...widget.crudItems.map(
          (e) => Column(
            children: [
              e,
              const CustomDivider(),
            ],
          ),
        ),
        ...(widget.crudType == CrudType.editOrDelete
            ? [
                ...(widget.deletable
                    ? []
                    : [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.note,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const CustomDivider(),
                      ]),
                CrudItem(
                  label: 'Deactivate?',
                  content: CustomSwitch(
                    label: 'region',
                    switchValue: true,
                    onChanged: (value) {},
                  ),
                ),
                const CustomDivider(),
                const CrudItem(
                  label: 'Deactivated:',
                  content: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'By: Andrew Sully on 12th Jan 2023',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
                const CustomDivider(),
              ]
            : []),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              widget.crudType == CrudType.editOrDelete
                  ? CustomButton(
                      backgroundColor: const Color(
                        0xfff58646,
                      ),
                      iconData: PhosphorIcons.pencilLine,
                      onClick: () {
                        widget.editEntity();
                        context.read<MastersTemplateBloc>().add(
                              const MastersTemplateCrudTypeChanged(
                                crudType: CrudType.add,
                              ),
                            );
                      },
                      text: 'Edit ${camelize(widget.label)}',
                    )
                  : CustomButton(
                      backgroundColor: const Color(
                        0xff059669,
                      ),
                      iconData: PhosphorIcons.plus,
                      onClick: widget.addEntity,
                      text: 'Add ${camelize(widget.label)}',
                    ),
              const SizedBox(
                width: 30,
              ),
              widget.crudType == CrudType.editOrDelete
                  ? CustomButton(
                      backgroundColor: const Color(
                        0xfff58686,
                      ),
                      iconData: PhosphorIcons.trashSimple,
                      onClick: widget.deleteEntity,
                      text: 'Delete',
                      isDisabled: !widget.deletable,
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
