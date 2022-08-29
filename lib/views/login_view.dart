
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mynotess/constant/routes.dart';

import '../utilities/show_error_dialog.dart';

class Loginview extends StatefulWidget {
  const Loginview({Key? key}) : super(key: key);

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
            children: [
              TextField(
                controller: _email,
                 enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email'
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password'
                ),
              ),
              TextButton(
                onPressed: () async{
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final UserCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, 
                    password: password,
                    );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute, 
                  (route) => false,
                  );
                  } on FirebaseAuthException
                   catch (e) {
                  if (e.code == 'user-not-found') {
                   await showErrorDialog(
                    context, 
                   'user not found',
                   );
                  }else if(e.code == 'wrong-password') {
                   await showErrorDialog(
                    context, 
                   'Wrong password',
                   );
                  } else {
                    await showErrorDialog(
                    context, 
                   'Error: ${e.code}',
                   );
                  }
                  } catch (e) {
                    await showErrorDialog(
                    context, 
                   e.toString(),
                   );
                  }
                  
                },
              child: const Text('Login'),),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                     (route) => false
                     );
                },
                child: const Text('Not registered yet? Register here!'),
                )
            ],
          ),
    );
  }
  
}

