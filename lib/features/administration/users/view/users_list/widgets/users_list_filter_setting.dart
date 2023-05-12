import '/common_libraries.dart';

class UserListFilterSettingView extends StatefulWidget {
  const UserListFilterSettingView({super.key});

  @override
  State<UserListFilterSettingView> createState() =>
      _UserListFilterSettingViewState();
}

class _UserListFilterSettingViewState extends State<UserListFilterSettingView> {
  late UserListFilterSettingBloc userListFilterSettingBloc;
  TextEditingController filterNameController = TextEditingController();

  @override
  void initState() {
    userListFilterSettingBloc = context.read()
      ..add(const UserListFilterSettingFilterSettingListLoaded(name: 'user'))
      ..add(
          const UserListFilterSettingUserFilterSettingListLoaded(name: 'user'));
    filterNameController.text =
        userListFilterSettingBloc.state.userFilterUpdate.filterName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListFilterSettingBloc, UserListFilterSettingState>(
      listener: (context, state) {
        filterNameController.text = state.userFilterUpdate.filterName;
      },
      listenWhen: (previous, current) =>
          previous.userFilterUpdate.id != current.userFilterUpdate.id,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(state),
              Builder(builder: (context) {
                if (state.userFilterSettingLoadStatus.isLoading) {
                  return const Loader();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBody(state),
                    _buildAddClauseButton(),
                    _buildFooter(state)
                  ],
                );
              })
            ],
          ),
        );
      },
    );
  }

  Column _buildBody(UserListFilterSettingState state) {
    return Column(
      children: state.userFilterUpdate.undeletedUserFilterItems.map(
        (userFilterItem) {
          return FilterSettingItemView(
            isFirst: state.userFilterUpdate.undeletedUserFilterItems
                    .indexOf(userFilterItem) ==
                0,
            filterSettingList: state.filterSettingList,
            userFilterItem: userFilterItem,
          );
        },
      ).toList(),
    );
  }

  Padding _buildAddClauseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 20,
      ),
      child: TextButton(
        onPressed: () => userListFilterSettingBloc
            .add(const UserListFilterSettingUserFilterItemAdded()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              PhosphorIcons.plus,
              size: 20,
              color: Colors.green,
            ),
            SizedBox(width: 3),
            Text(
              'Add new clause',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _buildFooter(UserListFilterSettingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 150,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Filter Name', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 30),
              SizedBox(
                width: 200,
                child: CustomTextField(
                    // initialValue: state.userFilterUpdate.filterName,
                    controller: filterNameController,
                    onChanged: (value) => userListFilterSettingBloc.add(
                        UserListFilterSettingUserFilterNameChanged(
                            filterName: value))),
              ),
              const SizedBox(width: 20),
              CustomSwitch(
                switchValue: state.userFilterUpdate.isDefault,
                onChanged: (value) => userListFilterSettingBloc.add(
                    UserListFilterSettingUserFilterIsDefaultChanged(
                        isDefault: value)),
                onlySwitch: true,
              ),
              const SizedBox(width: 10),
              const Text('Default', style: TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener<UserListFilterSettingBloc,
                  UserListFilterSettingState>(
                listener: (context, state) {
                  if (state.userFilterSettingUpdateStatus.isSuccess) {
                    userListFilterSettingBloc.add(
                        const UserListFilterSettingUserFilterSettingListLoaded(
                            name: 'user'));
                  }
                },
                listenWhen: (previous, current) =>
                    previous.userFilterSettingUpdateStatus !=
                    current.userFilterSettingUpdateStatus,
                child: ElevatedButton(
                  onPressed: () => userListFilterSettingBloc
                      .add(UserListFilterSettingUserFilterSettingUpdated()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              BlocListener<UserListFilterSettingBloc,
                  UserListFilterSettingState>(
                listener: (context, state) {
                  if (state.userFilterSettingDeleteStatus.isSuccess) {
                    userListFilterSettingBloc.add(
                        const UserListFilterSettingUserFilterSettingListLoaded(
                            name: 'user'));
                  }
                },
                listenWhen: (previous, current) =>
                    previous.userFilterSettingDeleteStatus !=
                    current.userFilterSettingDeleteStatus,
                child: ElevatedButton(
                  onPressed: () {
                    userListFilterSettingBloc.add(
                        UserListFilterSettingUserFilterSettingDeletedById(
                            filterId: state.userFilterUpdate.id));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3))),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildHeader(UserListFilterSettingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Filter',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      Map<String, UserFilterSetting> items = {};
                      for (var userFilterSetting
                          in state.userFilterSettingList) {
                        items.addEntries([
                          MapEntry(
                              userFilterSetting.filterName, userFilterSetting)
                        ]);
                      }
                      return SizedBox(
                        child: CustomSingleSelect(
                          selectedValue:
                              state.selectedUserFilterSetting?.filterName,
                          items: items,
                          hint: 'Select Filter',
                          // selectedValue: state.,
                          onChanged: (value) {
                            userListFilterSettingBloc.add(
                                UserListFilterSettingUserFilterSettingSelected(
                                    userFilterSetting: value.value));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  if (state.selectedUserFilterSetting != null) {
                    userListFilterSettingBloc.add(
                        UserListFilterSettingUserFilterSettingLoadedById(
                            filterId: state.selectedUserFilterSetting!.id));
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                child: const Text(
                  'Load',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterSettingItemView extends StatefulWidget {
  final bool isFirst;
  final List<FilterSetting> filterSettingList;
  final UserFilterItem userFilterItem;
  const FilterSettingItemView({
    super.key,
    this.isFirst = false,
    this.filterSettingList = const [],
    required this.userFilterItem,
  });

  @override
  State<FilterSettingItemView> createState() => _FilterSettingItemViewState();
}

class _FilterSettingItemViewState extends State<FilterSettingItemView> {
  late UserListFilterSettingBloc userListFilterSettingBloc;

  @override
  void initState() {
    userListFilterSettingBloc = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAddButton(),
          _buildDeleteButton(),
          const SizedBox(width: 5),
          _buildAndOrSelectField(),
          const SizedBox(width: 5),
          _buildColumnSelectField(),
          const SizedBox(width: 5),
          _buildOperatorSelectField(),
          const SizedBox(width: 5),
          _buildValueField(),
        ],
      ),
    );
  }

  Flexible _buildValueField() {
    final controlType = widget.userFilterItem.filterSetting.controlType;
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: controlType == 'Textbox'
          ? widget.userFilterItem.filterValue.isNotEmpty
              ? CustomTextField(
                  initialValue: widget.userFilterItem.filterValue[0],
                  onChanged: (value) => userListFilterSettingBloc
                          .add(UserListFilterSettingUserFilterItemValueChanged(
                        userFilterItem: widget.userFilterItem,
                        value: value,
                      )))
              : CustomTextField(
                  onChanged: (value) => userListFilterSettingBloc
                          .add(UserListFilterSettingUserFilterItemValueChanged(
                        userFilterItem: widget.userFilterItem,
                        value: value,
                      )))
          : controlType == 'Select'
              ? Builder(builder: (context) {
                  Map<String, String> map = {};
                  for (final item
                      in widget.userFilterItem.filterSetting.columnValues) {
                    map.addEntries([MapEntry(item, item)]);
                  }
                  return CustomSingleSelect(
                    selectedValue: widget.userFilterItem.filterValue[0],
                    items: map,
                    onChanged: (value) => userListFilterSettingBloc
                        .add(UserListFilterSettingUserFilterItemValueChanged(
                      userFilterItem: widget.userFilterItem,
                      value: value.key,
                    )),
                  );
                })
              : Container(
                  color: Colors.grey,
                ),
    );
  }

  SizedBox _buildOperatorSelectField() {
    return SizedBox(
      width: 150,
      child: CustomSingleSelect(
        selectedValue: widget.userFilterItem.operator,
        items: const {
          '=': '=',
          '<': '<',
          '<=': '<=',
          '>': '>',
          '>=': '>=',
          '!=': '!=',
          'Contains': 'Contains',
          'Not Contains': 'Not Contains',
          'IN': 'IN',
          'Not In': 'Not In',
        },
        onChanged: (value) => userListFilterSettingBloc.add(
            UserListFilterSettingUserFilterItemOperatorChanged(
                operator: value.value, userFilterItem: widget.userFilterItem)),
      ),
    );
  }

  Flexible _buildColumnSelectField() {
    return Flexible(
      flex: 2,
      fit: FlexFit.tight,
      child: Builder(builder: (context) {
        Map<String, FilterSetting> items = {};
        for (var filterSetting in widget.filterSettingList) {
          items
              .addEntries([MapEntry(filterSetting.columnTitle, filterSetting)]);
        }
        return CustomSingleSelect(
          hint: 'Select Column',
          items: items,
          selectedValue: widget.userFilterItem.filterSetting.columnTitle,
          onChanged: (value) => userListFilterSettingBloc.add(
              UserListFilterSettingUserFilterItemColumnChanged(
                  column: value.value, userFilterItem: widget.userFilterItem)),
        );
      }),
    );
  }

  IconButton _buildDeleteButton() {
    return IconButton(
      onPressed: () => userListFilterSettingBloc.add(
          UserListFilterSettingUserFilterItemDeleted(
              userFilterItem: widget.userFilterItem)),
      icon: const Icon(
        PhosphorIcons.x,
        color: Colors.red,
        size: 20,
      ),
    );
  }

  IconButton _buildAddButton() {
    return IconButton(
      onPressed: () => userListFilterSettingBloc.add(
          UserListFilterSettingUserFilterItemAdded(
              userFilterItem: widget.userFilterItem)),
      icon: const Icon(
        PhosphorIcons.plus,
        color: Colors.green,
        size: 20,
      ),
    );
  }

  SizedBox _buildAndOrSelectField() {
    return SizedBox(
      width: 100,
      child: widget.isFirst
          ? Container()
          : CustomSingleSelect(
              selectedValue: widget.userFilterItem.booleanCondition,
              items: const {'And': 'And', 'Or': 'Or'},
              onChanged: (value) => userListFilterSettingBloc.add(
                  UserListFilterSettingUserFilterItemBooleanConditionChanged(
                      booleanCondition: value.value,
                      userFilterItem: widget.userFilterItem)),
            ),
    );
  }
}
