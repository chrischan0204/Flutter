import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safety_eta/common_libraries.dart';
import 'package:safety_eta/features/auth/data/model/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPassword = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_authBloc.state.token.isNotEmpty) {
      // GoRouter.of(context).go('/dashboard');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.blueGrey, BlendMode.dstATop),
            image: NetworkImage(
                'https://images.unsplash.com/photo-1536532184021-da5392b55da1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2370&q=80'),
          ),
        ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.health_and_safety_sharp,
                          size: 44,
                          color: Colors.amberAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Safety ETA',
                          style: GoogleFonts.alumniSans(
                            textStyle: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Welcome to Safety',
                          style: GoogleFonts.amiko(
                            textStyle: TextStyle(
                              fontSize: width / 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 20,
                        ),
                        TextField(
                          controller: _usernameController,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey[900],
                          ),
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _passwordController,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey[900],
                          ),
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
                                isPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                        SizedBox(
                          height: width / 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: BlocConsumer<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthAuthenticateSuccess) {
                                GoRouter.of(context).go('/dashboard');
                              }
                            },
                            builder: (context, state) => ElevatedButton(
                              onPressed: () {
                                if (state is! AuthAuthenticateInProgress) {
                                  _authBloc.add(AuthAuthenticated(
                                      auth: Auth(
                                    email: _usernameController.text,
                                    password: _passwordController.text,
                                  )));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff68767b),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                              ),
                              child: state is AuthAuthenticateInProgress
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white,
                                      size: 26,
                                    )
                                  : Text(
                                      'Login',
                                      style: GoogleFonts.amaranth(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: width / 70,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: width / 60,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
