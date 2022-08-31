import 'package:flutter/material.dart';
import 'package:mynotess/constant/routes.dart';
import 'package:mynotess/services/auth/auth%20_service.dart';
import 'package:mynotess/views/Register_view.dart';
import 'package:mynotess/views/Verify_email_view.dart';
import 'package:mynotess/views/login_view.dart';

import 'package:mynotess/views/note_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const Loginview(),
        registerRoute: (context) => const Registerview(),
        notesRoute: (context) => const Noteview(),
        verifyEmailRoute: (context) => const verifyEmailview(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Authservice.Firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = Authservice.Firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const Noteview();
              } else {
                return const verifyEmailview();
              }
            } else {
              return const Loginview();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
