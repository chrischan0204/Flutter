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
    awarenessCategoriesBloc = context.read<AwarenessCategoriesBloc>();
    awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
    awarenessCategoriesBloc
        .add(AwarenessGroupsForAwarenessCategoriesRetrieved());
    if (widget.awarenessCategoryId != null) {
      awarenessCategoriesBloc.add(
        AwarenessCategorySelectedById(
            awarenessCategoryId: widget.awarenessCategoryId!),
      );
    } else {
      awarenessCategoriesBloc.add(
        const AwarenessCategorySelected(
          awarenessCategory: AwarenessCategory(
            name: '',
            groupId: '',
            groupName: '',
            active: true,
          ),
        ),
      );
    }

    super.initState();
  }

  void _addAwarenessCategory(AwarenessCategoriesState state) {
    if (!_validate()) return;
    awarenessCategoriesBloc.add(
      AwarenessCategoryAdded(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
  }

  void _editAwarenessCategory(AwarenessCategoriesState state) {
    if (!_validate()) return;
    awarenessCategoriesBloc.add(
      AwarenessCategoryEdited(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessCategoriesBloc, AwarenessCategoriesState>(
      listener: (context, state) {
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
        if (state.awarenessCategoryCrudStatus == EntityStatus.success) {
          awarenessCategoriesBloc.add(const AwarenessCategoriesStatusInited());
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
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'awareness category',
          id: widget.awarenessCategoryId,
          selectedEntity: state.selectedAwarenessCategory,
          addEntity: () => _addAwarenessCategory(state),
          crudStatus: state.awarenessCategoryCrudStatus,
          editEntity: () => _editAwarenessCategory(state),
          child: Column(
            children: [
              FormItem(
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
                          awarenessCategory:
                              state.selectedAwarenessCategory!.copyWith(
                            groupName: awarenessGroup.key,
                            groupId: awarenessGroup.value,
                          ),
                        ),
                      );
                    },
                  );
                }),
                message: awarenessGroupValidationMessage,
              ),
              FormItem(
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
                        awarenessCategory:
                            state.selectedAwarenessCategory!.copyWith(
                          name: awarenessCategoryName,
                        ),
                      ),
                    );
                  },
                ),
                message: awarenessCategoryValidationMessage,
              ),
              widget.awarenessCategoryId != null
                  ? FormItem(
                      label: 'Deactivate?',
                      content: CustomSwitch(
                        label: 'This observation type is deactivated',
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
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
