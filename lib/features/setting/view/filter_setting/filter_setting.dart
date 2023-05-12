import '/common_libraries.dart';
import 'widgets/filter_setting_item.dart';

class FilterSettingView extends StatefulWidget {
  final String viewName;
  const FilterSettingView({
    super.key,
    required this.viewName,
  });

  @override
  State<FilterSettingView> createState() => _FilterSettingViewState();
}

class _FilterSettingViewState extends State<FilterSettingView> {
  String token = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) =>
          setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => SettingsRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => FilterSettingBloc(
                      settingsRepository: RepositoryProvider.of(context))),
            ],
            child: FilterSettingWidget(
              viewName: widget.viewName,
            ),
          ),
        );
      },
    );
  }
}

class FilterSettingWidget extends StatefulWidget {
  final String viewName;
  const FilterSettingWidget({
    super.key,
    required this.viewName,
  });

  @override
  State<FilterSettingWidget> createState() => _FilterSettingWidgetState();
}

class _FilterSettingWidgetState extends State<FilterSettingWidget> {
  late FilterSettingBloc userListFilterSettingBloc;
  TextEditingController filterNameController = TextEditingController();

  @override
  void initState() {
    userListFilterSettingBloc = context.read()
      ..add(FilterSettingFilterSettingListLoaded(name: widget.viewName))
      ..add(FilterSettingUserFilterSettingListLoaded(name: widget.viewName));
    filterNameController.text =
        userListFilterSettingBloc.state.userFilterUpdate.filterName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilterSettingBloc, FilterSettingState>(
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
                // if (state.userFilterSettingLoadStatus.isLoading) {
                //   return const Loader();
                // }
                if (state.userFilterSettingList.isEmpty &&
                    state.userFilterUpdate.undeletedUserFilterItems.isEmpty) {
                  return const Center(
                    child: Text(
                      'There are no user filter settings. Please click Add Button to create new user filter setting',
                      style: TextStyle(fontSize: 14),
                    ),
                  );
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

  Column _buildBody(FilterSettingState state) {
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
            .add(const FilterSettingUserFilterItemAdded()),
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

  Padding _buildFooter(FilterSettingState state) {
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
                        FilterSettingUserFilterNameChanged(filterName: value))),
              ),
              const SizedBox(width: 20),
              CustomSwitch(
                switchValue: state.userFilterUpdate.isDefault,
                onChanged: (value) => userListFilterSettingBloc.add(
                    FilterSettingUserFilterIsDefaultChanged(isDefault: value)),
                onlySwitch: true,
              ),
              const SizedBox(width: 10),
              const Text('Default', style: TextStyle(fontSize: 14)),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocListener<FilterSettingBloc, FilterSettingState>(
                listener: (context, state) {
                  if (state.userFilterSettingUpdateStatus.isSuccess) {
                    CustomNotification(
                      context: context,
                      notifyType: NotifyType.success,
                      content: 'User filter saved successfully',
                    ).showNotification();
                  }
                },
                listenWhen: (previous, current) =>
                    previous.userFilterSettingUpdateStatus !=
                    current.userFilterSettingUpdateStatus,
                child: ElevatedButton(
                  onPressed: () => userListFilterSettingBloc
                      .add(FilterSettingUserFilterSettingUpdated()),
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
              BlocListener<FilterSettingBloc, FilterSettingState>(
                listener: (context, state) {
                  if (state.userFilterSettingDeleteStatus.isSuccess) {
                    CustomNotification(
                      context: context,
                      notifyType: NotifyType.success,
                      content: 'User filter deleted successfully',
                    ).showNotification();
                  }
                },
                listenWhen: (previous, current) =>
                    previous.userFilterSettingDeleteStatus !=
                    current.userFilterSettingDeleteStatus,
                child: ElevatedButton(
                  onPressed: () {
                    userListFilterSettingBloc.add(
                        FilterSettingUserFilterSettingDeletedById(
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

  Padding _buildHeader(FilterSettingState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserFilterSettingSelectField(state),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     if (state.selectedUserFilterSetting != null) {
                //       userListFilterSettingBloc.add(
                //           FilterSettingUserFilterSettingLoadedById(
                //               filterId: state.selectedUserFilterSetting!.id));
                //     }
                //   },
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(3),
                //     ),
                //   ),
                //   child: const Text(
                //     'Load',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 14,
                //     ),
                //   ),
                // ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => userListFilterSettingBloc
                      .add(FilterSettingUserFilterAdded()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildUserFilterSettingSelectField(FilterSettingState state) {
    return Expanded(
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
                for (var userFilterSetting in state.userFilterSettingList) {
                  items.addEntries([
                    MapEntry(userFilterSetting.filterName, userFilterSetting)
                  ]);
                }
                return SizedBox(
                  child: CustomSingleSelect(
                    selectedValue: state.selectedUserFilterSetting?.filterName,
                    items: items,
                    hint: 'Select Filter',
                    // selectedValue: state.,
                    onChanged: (value) {
                      userListFilterSettingBloc.add(
                          FilterSettingUserFilterSettingSelected(
                              userFilterSetting: value.value));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
