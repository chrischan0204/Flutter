import 'package:google_fonts/google_fonts.dart';
import 'package:safety_eta/common_libraries.dart';
import 'package:safety_eta/features/auth/data/model/auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPassword = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 2 / 7,
                margin: const EdgeInsets.all(50),
                padding: const EdgeInsets.all(80),
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
                          'Welcome to Safety ETA',
                          style: GoogleFonts.amiko(
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        TextField(
                          controller: usernameController,
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
                          controller: passwordController,
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
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              if (state is AuthAuthenticateSuccess) {
                                GoRouter.of(context).go('/dashboard');
                              }
                            },
                            child: ElevatedButton(
                              onPressed: () {
                                authBloc.add(AuthLogined(
                                    auth: Auth(
                                  email: usernameController.text,
                                  password: passwordController.text,
                                )));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff68767b),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                              ),
                              child: Text(
                                'Login',
                                style: GoogleFonts.amaranth(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                fontSize: 14,
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
