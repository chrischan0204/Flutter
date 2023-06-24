import '/common_libraries.dart';
import 'error_message.dart';

class UsernameField extends StatefulWidget {
  const UsernameField({super.key});

  @override
  State<UsernameField> createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  final TextEditingController _usernameController = TextEditingController();
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = context.read();
    super.initState();
  }

  void _onUsernameChange(String username) =>
      _loginBloc.add(LoginUsernameChanged(username: username));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _usernameController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[900],
                  ),
                  onChanged: (username) => _onUsernameChange(username),
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: const Color(0xfffbfafb),
                    fillColor: const Color(0xffeae8ea),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(
                      Icons.person_2,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    hintText: 'Username',
                  ),
                ),
                ErrorMessageView(
                    validationMessage: state.usernameValidationmessage),
              ],
            ));
  }
}
