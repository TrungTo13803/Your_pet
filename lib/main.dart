import 'package:demo/views/user_auth_views/login_view.dart';
import 'package:demo/views/user_auth_views/user_auth_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:demo/views/user_auth_views/register_view.dart';
//import 'package:demo/views/main_page.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyHome(), // Wrap your app
    )
  );
}  


class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: "yourPets",
        home: const UserAuthView(),
        routes: {
          '/login/': (context) => const LoginView(),
          '/register/': (context) => const RegisterView(),
        },
    );
  }
}

