import 'package:demo/constrants/routes.dart';
import 'package:demo/services/auth/auth_exceptions.dart';
import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/views/user_auth_views/show_error_dialog.dart';
import 'package:flutter/material.dart';

// Register view
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Register new yourPets account',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'New journey along with your pets!',
              style: TextStyle(
                color: Color(0xff212121),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
            child: TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff2271ff)),
                  borderRadius: BorderRadius.circular(16),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 10),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff2271ff)),
                  borderRadius: BorderRadius.circular(16),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MaterialButton(
                  elevation: 0,
                  color: const Color(0xFF0051FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuthService.firebase().createUser(
                        email: email,
                        password: password,
                      );
                      AuthService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamed(verifyEmailRoute);
                    } on WeakPasswordAuthException {
                      await showErrorDialogRegister(
                          context, 'Weak password (min 8 characters)');
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialogRegister(
                          context, 'Email already in use');
                    } on InvalidEmailAuthException {
                      await showErrorDialogRegister(context, 'Invalid email');
                    } on GenericAuthException {
                      await showErrorDialogRegister(context, 'Error');
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text(
              'Already have an account? Login',
            ),
          )
        ],
      ),
    );
  }
}
