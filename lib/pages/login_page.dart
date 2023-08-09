import 'package:briessenchecker/services/dbhelper.dart';
import 'package:briessenchecker/services/scaffold_messenger.dart';
import 'package:briessenchecker/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double dialogWidth = screenSize.width > 300 ? 300 : screenSize.width;
    return Stack(children: [
      Image.network(
        'https://vkyxfurwyfjfvjlseegf.supabase.co/storage/v1/object/sign/assets/nekro_wallpaper.jpg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhc3NldHMvbmVrcm9fd2FsbHBhcGVyLmpwZyIsImlhdCI6MTY5MTU5NTI3MywiZXhwIjoxNzIzMTMxMjczfQ.fRSqj5N0oZq2G3rTW3fHbuaThin9oQ5Ygrvs58upUog&t=2023-08-09T15%3A34%3A33.717Z',
        width: screenSize.width,
        height: screenSize.height,
        fit: BoxFit.cover,
      ),
      Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (screenSize.width > 760)
                Text(
                  'BRISEN',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.network(
                  'https://vkyxfurwyfjfvjlseegf.supabase.co/storage/v1/object/sign/assets/logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJhc3NldHMvbG9nby5wbmciLCJpYXQiOjE2OTE1OTUyNTcsImV4cCI6MTcyMzEzMTI1N30.EZeMK8bfz83jk1ELdPga0VhyedwZ4ZKDsUEGPR0QBBM&t=2023-08-09T15%3A34%3A17.513Z',
                  width: 200,
                ),
              ),
              if (screenSize.width > 760)
                Text(
                  'CHECKER',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontFamily: 'Cinzel',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                )
            ],
          )),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              backgroundBlendMode: BlendMode.luminosity,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 300,
            width: dialogWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      autofillHints: const [
                        'email',
                        'username',
                        'name',
                        'login',
                        'mail'
                      ],
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(label: Text('Email')),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    PasswordField(
                      controller: passwordController,
                      onSubmitted: () => _loginSubmitted(emailController.text,
                          passwordController.text, context),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    FloatingActionButton.extended(
                        onPressed: () => _loginSubmitted(emailController.text,
                            passwordController.text, context),
                        label: const Text('Login'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  void _loginSubmitted(String email, String password, BuildContext context) {
    DbHelper.login(email, password).onError(
      (AuthException error, stackTrace) =>
          Messenger.showError(context, error.message),
    );
  }
}
