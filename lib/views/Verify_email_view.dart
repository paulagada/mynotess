import 'package:flutter/material.dart';
import 'package:mynotess/constant/routes.dart';
import 'package:mynotess/services/auth/auth%20_service.dart';

class verifyEmailview extends StatefulWidget {
  const verifyEmailview({Key? key}) : super(key: key);

  @override
  _verifyEmailviewState createState() => _verifyEmailviewState();
}

class _verifyEmailviewState extends State<verifyEmailview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify email'),
      ),
      body: Column(
        children: [
          const Text(
              "we've sent you an email verification, please open it to verify your account."),
          const Text(
              "If you haven't received a verifocation email yet, press the button below"),
          TextButton(
            onPressed: () async {
              await Authservice.Firebase().sendEmailVerification();
            },
            child: const Text('send email verification'),
          ),
          TextButton(
            onPressed: () async {
              await Authservice.Firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
