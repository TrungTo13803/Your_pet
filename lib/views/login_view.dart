import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo/firebase_options.dart';

// Login view 
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _LoginViewPageUI(email: _email, password: _password);
              
            default:
              return const Text('Loading...');
          }
        }
      )
    );
  }
}

class _LoginViewPageUI extends StatelessWidget {
  const _LoginViewPageUI({
    required TextEditingController email,
    required TextEditingController password,
  }) : _email = email, _password = password;

  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email'
            ),
          ),  
        ),
            
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Password'
            ),
          ),
        ),
      
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email, 
                  password: password
                );
                print(userCredential);
              } on FirebaseAuthException catch(e) {
                if (e.code == 'user-not-found') {
                  print('User not found');  
                } else if (e.code == 'wrong-password') {
                  print('Wrong password');
                }  
              }
            },
            style: const ButtonStyle( 
            ),
            child: const Text('Login'),
          ),
        )
      ],
    );
  }
}