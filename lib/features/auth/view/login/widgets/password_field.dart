import '/common_libraries.dart';
import 'error_message.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  bool isPassword = true;

  @override
  void initState() {
    _loginBloc = context.read();
    super.initState();
  }

  void _onPasswordChange(String password) =>
      _loginBloc.add(LoginPasswordChanged(password: password));

  void _validate() => _loginBloc.add(LoginValidationChecked());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (contex, state) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _passwordController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueGrey[900],
                  ),
                  onChanged: (password) => _onPasswordChange(password),
                  onSubmitted: (_) => _validate(),
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
                      Icons.lock_open_outlined,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () => setState(() {
                        isPassword = !isPassword;
                      }),
                    ),
                    hintText: 'Password',
                  ),
                  obscureText: isPassword,
                ),
                ErrorMessage(
                    validationMessage: state.passwordValidationMessage),
              ],
            ));
  }
}
