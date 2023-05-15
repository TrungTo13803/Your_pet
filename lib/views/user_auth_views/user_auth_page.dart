import 'package:demo/services/auth/auth_service.dart';
import 'package:demo/views/main_page.dart';
import 'package:demo/views/user_auth_views/login_view.dart';
import 'package:demo/views/user_auth_views/verify_email_view.dart';
import 'package:flutter/material.dart';

// Login view
class UserAuthView extends StatelessWidget {
  const UserAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified) {
                  return const MainPageView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
