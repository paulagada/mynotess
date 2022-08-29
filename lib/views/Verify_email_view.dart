import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class verifyEmailview extends StatefulWidget {
  const verifyEmailview
  ({Key? key}) : super(key: key);

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
            const Text('please verify your email adress'),
            TextButton(
              onPressed: () async{
                final user = FirebaseAuth.instance.currentUser;
               await user?.sendEmailVerification();
              },
             child: const Text('send email verification'),
            )
          ],),
    );
  }
}