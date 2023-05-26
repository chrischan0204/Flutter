import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:strings/strings.dart';

import '/constants/style.dart';
import '/constants/color.dart';
import '/data/model/entity.dart';
import '/global_widgets/global_widget.dart';

class AddEditEntityTemplate extends StatefulWidget {
  final String label;
  final String? id;
  final Entity? selectedEntity;
  final Map<String, Widget> tabItems;
  final double tabWidth;
  final String? view;
  final Widget child;
  final String? addButtonName;
  final String? editButtonName;
  final bool isCrudDataFill;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  final EntityStatus crudStatus;
  const AddEditEntityTemplate({
    super.key,
    required this.label,
    this.id,
    this.selectedEntity,
    this.tabItems = const {},
    this.tabWidth = 300,
    this.view,
    required this.child,
    this.addButtonName,
    this.editButtonName,
    this.isCrudDataFill = false,
    required this.addEntity,
    required this.editEntity,
    this.crudStatus = EntityStatus.initial,
  });

  @override
  State<AddEditEntityTemplate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddEditEntityTemplate> {
  late int selectedTabIndex;

  @override
  void initState() {
    selectedTabIndex = widget.view == 'created' ? 1 : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - topbarHeight - 20),
      height: MediaQuery.of(context).size.height - topbarHeight - 20,
      child: SingleChildScrollView(
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
              widget.tabItems.isNotEmpty && widget.id != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTab(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          selectedTabIndex != 0
                              ? widget.tabItems.entries
                                  .toList()[selectedTabIndex]
                                  .value
                              : _buildEditEntityView(),
                        ],
                      ),
                    )
                  : _buildEditEntityView(),
            ],
          ),
        ),
      ),
    );
  }

  CustomTab _buildTab() {
    return CustomTab(
      initialIndex: selectedTabIndex,
      onSelect: (int index) => setState(() {
        selectedTabIndex = index;
      }),
      containerBorderRadius: 6,
      containerColor: Colors.transparent,
      slidersBorder: Border.all(color: grey),
      slidersColors: const [
        Colors.white,
      ],
      containerHeight: 42,
      containerWidth: widget.tabWidth,
      borderColor: grey,
      children: widget.tabItems.entries
          .map(
            (tabItem) => Text(
              tabItem.key,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w400,
                color: darkTeal,
              ),
            ),
          )
          .toList(),
    );
  }

  Column _buildEditEntityView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        _buildDeactivationInfo(),
        _buildAddEditButton(),
      ],
    );
  }

  Widget _buildDeactivationInfo() {
    return widget.id != null &&
            widget.selectedEntity != null &&
            !widget.selectedEntity!.active &&
            widget.selectedEntity!.deactivationDate != null &&
            widget.selectedEntity!.deactivationUserName != null
        ? StatefulBuilder(builder: (context, setState) {
            Map<String, dynamic> map =
                widget.selectedEntity!.detailItemsToMap();
            return FormItem(
              label: 'Deactivated',
              content: Text(
                map['Deactivated'] ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'OpenSans',
                ),
              ),
            );
          })
        : Container();
  }

  Widget _buildAddEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: widget.crudStatus.isLoading
          ? CustomButton(
              backgroundColor: successColor,
              hoverBackgroundColor: successHoverColor,
              disabled: true,
              body: LoadingAnimationWidget.prograssiveDots(
                color: Colors.white,
                size: 22,
              ),
            )
          : CustomButton(
              backgroundColor: successColor,
              hoverBackgroundColor: successHoverColor,
              iconData: PhosphorIcons.arrowRight,
              text: widget.id == null
                  ? widget.addButtonName ?? 'Add ${camelize(widget.label)}'
                  : widget.editButtonName ?? 'Edit ${camelize(widget.label)}',
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
      title: (widget.id == null
          ? 'New ${camelize(widget.label)}'
          : widget.selectedEntity != null
              ? 'Editing ${camelize(widget.label)} - ${widget.selectedEntity!.name ?? ''}'
              : ''),
    );
  }

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildGoToListButton(context),
        widget.id != null
            ? SizedBox(
                width: MediaQuery.of(context).size.width / 40,
              )
            : Container(),
        widget.id != null ? _buildShowButton(context) : Container(),
        const SizedBox(
          width: 50,
        )
      ],
    );
  }

  CustomButton _buildShowButton(BuildContext context) {
    return CustomButton(
      backgroundColor: purpleColor,
      hoverBackgroundColor: purpleHoverColor,
      iconData: PhosphorIcons.notePencil,
      text: 'Show ${camelize(widget.label)}',
      onClick: () {
        String location = GoRouter.of(context).location;
        int index = location.indexOf('edit');
        location = location.replaceRange(index, null, 'show/${widget.id}');
        GoRouter.of(context).go(location);
      },
    );
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primaryHoverColor,
      iconData: PhosphorIcons.listNumbers,
      text: '${camelize(widget.label)} List',
      onClick: () {
        if (widget.isCrudDataFill && widget.id == null) {
          AwesomeDialog(
            context: context,
            width: MediaQuery.of(context).size.width / 4,
            dialogType: DialogType.question,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Confirm',
            dialogBorderRadius: BorderRadius.circular(5),
            desc: 'Data that was entered will be lost ..... Proceed?',
            buttonsTextStyle: const TextStyle(color: Colors.white),
            showCloseIcon: true,
            btnCancelOnPress: () {},
            btnOkOnPress: () => _goToList(),
            btnOkText: 'Proceed',
            buttonsBorderRadius: BorderRadius.circular(3),
            padding: const EdgeInsets.all(10),
          ).show();
        } else {
          _goToList();
        }
      },
    );
  }

  void _goToList() {
    String location = GoRouter.of(context).location;
    if (widget.id == null) {
      location = location.replaceAll('new', '');
    } else {
      location = location.replaceRange(location.indexOf('edit'), null, '');
    }
    GoRouter.of(context).go(location);
  }
}
