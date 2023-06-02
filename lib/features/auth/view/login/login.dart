import '/common_libraries.dart';
import 'widgets/widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthBloc _authBloc;

  static ImageProvider backgroundImage = const NetworkImage(
      'https://images.unsplash.com/photo-1536532184021-da5392b55da1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80');

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.authUser != null) {
      _goToDashboard();
    }
    super.didChangeDependencies();
  }

  void _goToDashboard() => GoRouter.of(context).go('/dashboard');

  void _checkAuthentication(AuthState state) {
    if (state is AuthAuthenticateSuccess) {
      _goToDashboard();
    } else if (state is AuthAuthenticateFailure) {
      CustomNotification(
        context: context,
        notifyType: NotifyType.error,
        content: 'Invalid Credentials',
      ).showNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(Colors.blueGrey, BlendMode.dstATop),
            image: backgroundImage,
          ),
        ),
        child: BlocProvider(
          create: (context) => LoginBloc(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: width * 2 / 7,
                  margin: const EdgeInsets.all(50),
                  padding: EdgeInsets.all(width / 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) => _checkAuthentication(state),
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Logo(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DecorationText(),
                              SizedBox(
                                height: width / 20,
                              ),
                              const UsernameField(),
                              const PasswordField(),
                              const LoginButton(),
                              SizedBox(
                                height: width / 60,
                              ),
                              const ForgotPasswordButton(),
                            ],
                          ),
                          Container(),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
