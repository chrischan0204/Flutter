import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:safety_eta/features/administration/masters/masters_widgets/masters_list_template/widgets/page_title.dart';
import 'package:strings/strings.dart';

import '/data/model/entity.dart';
import '/global_widgets/global_widget.dart';

class AddEditMasterTemplate extends StatefulWidget {
  final String label;
  final String? id;
  final Entity? selectedEntity;
  final Widget child;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  const AddEditMasterTemplate({
    super.key,
    required this.label,
    this.id,
    this.selectedEntity,
    required this.child,
    required this.addEntity,
    required this.editEntity,
  });

  @override
  State<AddEditMasterTemplate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddEditMasterTemplate> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitle(),
                  const SizedBox(
                    width: 15,
                  ),
                  _buildCrudButtons(context)
                ],
              ),
            ),
            const CustomDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 6,
              ),
              child: Text(
                'Fill in the details below to create a ${widget.label}. Fields with (*) are required.',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            const CustomDivider(),
            widget.child,
            _buildAddEditButton()
          ],
        ),
      ),
    );
  }

  Padding _buildAddEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: CustomButton(
        backgroundColor: const Color(0xff059669),
        hoverBackgroundColor: const Color(0xff05875f),
        iconData: PhosphorIcons.arrowRight,
        text: '${widget.id == null ? 'Add' : 'Edit'} ${camelize(widget.label)}',
        onClick: () {
          if (widget.id != null) {
            widget.editEntity();
          } else {
            widget.addEntity();
          }
        },
      ),
    );
  }

  Widget _buildTitle() {
    return PageTitle(
      title: widget.id == null
          ? 'New ${camelize(widget.label)}'
          : widget.selectedEntity != null
              ? 'Editing ${camelize(widget.label)} - ${widget.selectedEntity!.name ?? ''}'
              : '',
    );
  }

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          backgroundColor: const Color(0xff0c83ff),
          hoverBackgroundColor: const Color(0xff0b76e6),
          iconData: PhosphorIcons.listNumbers,
          text: '${camelize(widget.label)} List',
          onClick: () {
            String location = GoRouter.of(context).location;
            if (widget.id == null) {
              location = location.replaceAll('new', '');
            } else {
              location =
                  location.replaceRange(location.indexOf('edit'), null, '');
            }
            GoRouter.of(context).go(location);
          },
        ),
        widget.id != null
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              )
            : Container(),
        widget.id != null
            ? CustomButton(
                backgroundColor: const Color(0xff8e70c1),
                hoverBackgroundColor: const Color(0xff8065ae),
                iconData: PhosphorIcons.notePencil,
                text: 'Show ${camelize(widget.label)}',
                onClick: () {
                  String location = GoRouter.of(context).location;
                  location = location.replaceAll('edit', 'show');
                  GoRouter.of(context).go(location);
                },
              )
            : Container()
      ],
    );
  }
}
