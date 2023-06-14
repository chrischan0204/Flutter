import 'package:flutter/material.dart';

import '/utils/custom_notification.dart';
import '/global_widgets/global_widget.dart';
import '/data/bloc/bloc.dart';
import '/data/model/model.dart';

class AddEditAwarenessCategoryView extends StatefulWidget {
  final String? awarenessCategoryId;
  const AddEditAwarenessCategoryView({
    super.key,
    this.awarenessCategoryId,
  });

  @override
  State<AddEditAwarenessCategoryView> createState() =>
      _AddEditAwarenessCategoryViewState();
}

class _AddEditAwarenessCategoryViewState
    extends State<AddEditAwarenessCategoryView> {
  late AwarenessCategoriesBloc awarenessCategoriesBloc;

  static String pageLabel = 'awareness category';

  TextEditingController awarenessCategoryNameController = TextEditingController(
    text: '',
  );
  String? awarenessCategoryGroupId;
  String? awarenessCategoryGroupName;
  bool awarenessCategoryDeactive = false;

  bool isFirstInit = true;

  String awarenessGroupValidationMessage = '';
  String awarenessCategoryValidationMessage = '';

  @override
  void initState() {
    awarenessCategoriesBloc = context.read<AwarenessCategoriesBloc>()
      ..add(const AwarenessCategoriesStatusInited())
      ..add(AwarenessGroupsForAwarenessCategoriesRetrieved());

    if (widget.awarenessCategoryId != null) {
      // in case of edit mode
      awarenessCategoriesBloc.add(
        AwarenessCategorySelectedById(
            awarenessCategoryId: widget.awarenessCategoryId!),
      );
    } else {
      // in case of add mode
      awarenessCategoriesBloc.add(
        const AwarenessCategorySelected(
          awarenessCategory: AwarenessCategory(),
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      listener: (context, state) {
        _changeFormData(state);
        _checkCrudResult(state, context);
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.awarenessCategoryId,
          selectedEntity: state.selectedAwarenessCategory,
          addEntity: () => _addAwarenessCategory(state),
          crudStatus: state.awarenessCategoryCrudStatus,
          editEntity: () => _editAwarenessCategory(state),
          child: Column(
            children: [
              _buildAwarenessGroupSelectField(state),
              _buildAwarenessCategoryNameTextField(state),
              _buildDeactivateAwarenessCategorySwitch(state),
            ],
          ),
        );
      },
    );
  }

  // return switch input to activate or deactivate awareness category
  StatelessWidget _buildDeactivateAwarenessCategorySwitch(
      AwarenessCategoriesState state) {
    return widget.awarenessCategoryId != null
        ? FormItem(
            label: 'Deactivate?',
            content: CustomSwitch(
              label: 'This awareness group is deactivated',
              switchValue: awarenessCategoryDeactive,
              onChanged: (active) {
                awarenessCategoriesBloc.add(
                  AwarenessCategorySelected(
                    awarenessCategory:
                        state.selectedAwarenessCategory!.copyWith(
                      active: !active,
                    ),
                  ),
                );
              },
            ),
          )
        : Container();
  }

  // return text field for awareness category name
  FormItem _buildAwarenessCategoryNameTextField(
      AwarenessCategoriesState state) {
    return FormItem(
      label: 'Awareness Category (*)',
      content: CustomTextField(
        controller: awarenessCategoryNameController,
        hintText: 'Awareness Category',
        onChanged: (awarenessCategoryName) {
          setState(() {
            awarenessCategoryValidationMessage = '';
          });
          awarenessCategoriesBloc.add(
            AwarenessCategorySelected(
              awarenessCategory: state.selectedAwarenessCategory!.copyWith(
                name: awarenessCategoryName,
              ),
            ),
          );
        },
      ),
      message: awarenessCategoryValidationMessage,
    );
  }

  // return select field for awareness group
  FormItem _buildAwarenessGroupSelectField(AwarenessCategoriesState state) {
    return FormItem(
      label: 'Awareness Group (*)',
      content: Builder(builder: (context) {
        Map<String, String> awarenessGroupItems = {};
        awarenessGroupItems.addEntries(
          state.awarenessGroups.map(
            (awarenessGroup) => MapEntry(
              awarenessGroup.name!,
              awarenessGroup.id!,
            ),
          ),
        );

        return CustomSingleSelect(
          items: awarenessGroupItems,
          hint: 'Select Awareness Group',
          selectedValue: awarenessCategoryGroupName,
          onChanged: (awarenessGroup) {
            setState(() {
              awarenessGroupValidationMessage = '';
            });
            awarenessCategoriesBloc.add(
              AwarenessCategorySelected(
                awarenessCategory: state.selectedAwarenessCategory!.copyWith(
                  groupName: awarenessGroup.key,
                  groupId: awarenessGroup.value,
                ),
              ),
            );
          },
        );
      }),
      message: awarenessGroupValidationMessage,
    );
  }

  void _clearForm(AwarenessCategoriesState state) {
    if (widget.awarenessCategoryId == null) {
      awarenessCategoryNameController.clear();
      awarenessCategoriesBloc.add(
        AwarenessCategorySelected(
          awarenessCategory:
              state.selectedAwarenessCategory!.copyWith(groupName: ''),
        ),
      );
    }
  }

  // check whenever the crud status changes
  void _checkCrudResult(AwarenessCategoriesState state, BuildContext context) {
    if (state.awarenessCategoryCrudStatus == EntityStatus.success) {
      awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
      _clearForm(state);
      CustomNotification(
        context: context,
        notifyType: NotifyType.success,
        content: state.message,
      ).showNotification();
    }
    if (state.awarenessCategoryCrudStatus == EntityStatus.failure) {
      awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
      setState(() {
        awarenessCategoryValidationMessage = state.message;
      });
    }
  }

  // change the form data whenever the state changes
  void _changeFormData(AwarenessCategoriesState state) {
    if (state.selectedAwarenessCategory != null) {
      awarenessCategoryGroupId =
          state.selectedAwarenessCategory!.groupId.isEmpty
              ? null
              : state.selectedAwarenessCategory!.groupId;
      awarenessCategoryGroupName =
          state.selectedAwarenessCategory!.groupName.isEmpty
              ? null
              : state.selectedAwarenessCategory!.groupName;
      awarenessCategoryDeactive = !state.selectedAwarenessCategory!.active;
      if (isFirstInit) {
        awarenessCategoryNameController.text =
            widget.awarenessCategoryId == null
                ? ''
                : state.selectedAwarenessCategory!.name ?? '';
        isFirstInit = false;
      }
    }
  }

  // add awareness category
  void _addAwarenessCategory(AwarenessCategoriesState state) {
    // check validation
    if (!_validate()) return;
    // call the event to add awareness category
    awarenessCategoriesBloc.add(
      AwarenessCategoryAdded(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
  }

  // edit awareness category
  void _editAwarenessCategory(AwarenessCategoriesState state) {
    // check validation
    if (!_validate()) return;
    // call the event to edit awareness category
    awarenessCategoriesBloc.add(
      AwarenessCategoryEdited(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
  }

  // check if fields are empty
  bool _validate() {
    bool validated = true;
    if (awarenessCategoryGroupName == null ||
        (awarenessCategoryGroupName != null &&
            (awarenessCategoryGroupName!.isEmpty ||
                awarenessCategoryGroupName!.trim().isEmpty))) {
      setState(() {
        awarenessGroupValidationMessage = 'Awareness group is required.';
      });
      validated = false;
    }
    if (awarenessCategoryNameController.text.isEmpty ||
        awarenessCategoryNameController.text.trim().isEmpty) {
      setState(() {
        awarenessCategoryValidationMessage = 'Awareness category is required.';
      });
      validated = false;
    }
    return validated;
  }
}
