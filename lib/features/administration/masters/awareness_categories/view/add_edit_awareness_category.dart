import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  FocusNode awarenessCategoryNameFocusNode = FocusNode();
  bool isFirstInit = true;

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
        AwarenessCategorySelected(
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
    awarenessCategoriesBloc.add(
      AwarenessCategoryAdded(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
  }

  void _editAwarenessCategory(AwarenessCategoriesState state) {
    awarenessCategoriesBloc.add(
      AwarenessCategoryEdited(
        awarenessCategory: state.selectedAwarenessCategory!.copyWith(
          name: awarenessCategoryNameController.text,
        ),
      ),
    );
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
        if (state.awarenessCategoryAddedStatus == EntityStatus.succuess ||
            state.awarenessCategoryAddedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/awareness-categories');
        }

        if (state.awarenessCategoryEditedStatus == EntityStatus.succuess ||
            state.awarenessCategoryEditedStatus == EntityStatus.failure) {
          GoRouter.of(context).go('/awareness-categories');
        }
      },
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: 'awareness category',
          id: widget.awarenessCategoryId,
          selectedEntity: state.selectedAwarenessCategory,
          addEntity: () => _addAwarenessCategory(state),
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
                message: '',
              ),
              FormItem(
                label: 'Awareness Category (*)',
                content: CustomTextField(
                  focusNode: awarenessCategoryNameFocusNode,
                  controller: awarenessCategoryNameController,
                  hintText: 'Awareness Category',
                  onChanged: (awarenessCategoryName) {
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
                message: '',
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
                      message: '',
                    )
                  : Container(),
              // FormItem(
              //   label: 'Deactivated:',
              //   content: Text('By: Andrew Sully on 12th Jan 2023'),
              //   message: '',
              // ),
            ],
          ),
        );
      },
    );
  }
}
