import '/common_libraries.dart';

class UserListFilterSettingView extends StatefulWidget {
  const UserListFilterSettingView({super.key});

  @override
  State<UserListFilterSettingView> createState() =>
      _UserListFilterSettingViewState();
}

class _UserListFilterSettingViewState extends State<UserListFilterSettingView> {
  @override
  Widget build(BuildContext context) {
    return const FilterSettingView(viewName: 'user');
  }
}
