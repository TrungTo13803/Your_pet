import 'package:demo/views/account_children_views/change_email_view.dart';
import 'package:demo/views/account_children_views/change_password_view.dart';
import 'package:demo/views/account_children_views/personal_info_view.dart';
import 'package:demo/views/account_page.dart';
import 'package:demo/views/main_page.dart';
import 'package:demo/views/new_note_view.dart';
import 'package:demo/views/new_pet_view.dart';
import 'package:demo/views/new_schedule_view.dart';
import 'package:demo/views/pets_list_view.dart';
import 'package:demo/views/schedule_view.dart';
import 'package:demo/views/update_note_view.dart';
import 'package:demo/views/update_pet_view.dart';
import 'package:demo/views/update_schedule_view.dart';
import 'package:demo/views/user_auth_views/forgot_password_view.dart';
import 'package:demo/views/user_auth_views/login_view.dart';
import 'package:demo/views/user_auth_views/user_auth_page.dart';
import 'package:demo/views/user_auth_views/verify_email_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:demo/views/user_auth_views/register_view.dart';
import 'package:demo/constrants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyHome(), // Wrap your app
  ));
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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const MainPageView(),
        accountRoute: (context) => const AccountPage(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newPetRoute: (context) => const CreatePetView(),
        petsListRoute: (context) => const AllPetsListView(),
        createPetRoute: (context) => const CreatePetView(),
        updatePetRoute: (context) => const UpdatePetView(),
        scheduleRoute: (context) => const ScheduleView(),
        createScheduleRoute: (context) => const CreateScheduleView(),
        updateScheduleRoute: (context) => const UpdateScheduleView(),
        personalInfoRoute: (context) => const PersonalInfoView(),
        changeEmailRoute: (context) => const ChangeEmailView(),
        createNoteRoute: (context) => const CreateNoteView(),
        updateNoteRoute: (context) => const UpdateNoteView(),
        forgotPasswordRoute: (context) => const ForgotPasswordView(),
        changePasswordRoute: (context) => const ChangePasswordView(),
      },
    );
  }
}
