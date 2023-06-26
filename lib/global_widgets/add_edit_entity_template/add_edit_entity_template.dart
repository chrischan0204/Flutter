import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '/common_libraries.dart';
import 'package:strings/strings.dart';

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
  final bool formDirty;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  final EntityStatus crudStatus;
  final Future<bool> Function(int)? onTabClick;
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
    this.formDirty = true,
    required this.addEntity,
    required this.editEntity,
    this.crudStatus = EntityStatus.initial,
    this.onTabClick,
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
    return Padding(
      padding: inset10,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        (widget.id == null
                            ? 'New ${camelize(widget.label)}'
                            : widget.selectedEntity != null
                                ? 'Editing ${camelize(widget.label)} - ${widget.selectedEntity!.name ?? ''}'
                                : ''),
                        style: textSemiBold18,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ),
                    spacerx15,
                    Expanded(
                      flex: 1,
                      child: _buildCrudButtons(context),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: inset20,
                  child: CustomScrollViewWithBackButton(
                    child: widget.tabItems.isNotEmpty && widget.id != null
                        ? _buildTab()
                        : _buildEditEntityView(),
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
      tabs: {'Details': _buildEditEntityView(), ...widget.tabItems},
      onTabClick: (index) async {
        if (widget.onTabClick != null) {
          return await widget.onTabClick!(index);
        } else {
          if (index == 0) {
            context
                .read<FormDirtyBloc>()
                .add(FormDirtyChanged(isDirty: widget.formDirty));
          } else {
            context
                .read<FormDirtyBloc>()
                .add(const FormDirtyChanged(isDirty: false));
          }
          return true;
        }
      },
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
          child: DefaultTextStyle(
            style: textSemiBold14,
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 300),
              animatedTexts: [
                TyperAnimatedText(
                    'Fill in the details below to create ${widget.label}. Fields with (*) are required.'),
              ],
            ),
          ),
        ),
        const CustomDivider(),
        widget.child,
        // _buildDeactivationInfo(),
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
              iconData: PhosphorIcons.regular.arrowRight,
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

  Row _buildCrudButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildGoToListButton(context),
        if (widget.id != null) spacerx20,
        if (widget.id != null) _buildShowButton(context),
        spacerx20,
      ],
    );
  }

  CustomButton _buildShowButton(BuildContext context) {
    return CustomButton(
      backgroundColor: purpleColor,
      hoverBackgroundColor: purpleHoverColor,
      iconData: PhosphorIcons.regular.notePencil,
      text: 'Show ${camelize(widget.label)}',
      onClick: () {
        if (context.read<FormDirtyBloc>().state.isDirty) {
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
            btnOkOnPress: () => _goToShow(),
            btnOkText: 'Proceed',
            buttonsBorderRadius: BorderRadius.circular(3),
            padding: const EdgeInsets.all(10),
          ).show();
        } else {
          _goToShow();
        }
      },
    );
  }

  void _goToShow() {
    String location = GoRouter.of(context).location;
    int index = location.indexOf('edit');
    location = location.replaceRange(index, null, 'show/${widget.id}');
    GoRouter.of(context).go(location);
  }

  CustomButton _buildGoToListButton(BuildContext context) {
    return CustomButton(
      backgroundColor: primaryColor,
      hoverBackgroundColor: primaryHoverColor,
      iconData: PhosphorIcons.regular.listNumbers,
      text: '${camelize(widget.label)} List',
      onClick: () {
        if (context.read<FormDirtyBloc>().state.isDirty) {
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
