import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotess/firebase_options.dart';
import 'package:mynotess/views/Register_view.dart';
import 'package:mynotess/views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
      routes: {
        '/login/':(context) => const Loginview(),
        '/register/':(context) => const Registerview(),
      },
    ),
 );
}
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done:
           // final user = FirebaseAuth.instance.currentUser;
            //print(user);
            //if (user?.emailVerified ?? false){
              //return const Text('done');
           // } else { 
             //  return const verifyEmailview();   
           // }
           return const Loginview();
          default:
        return const CircularProgressIndicator();
        }
          
        },
      );
  }
}

class verifyEmailview
 extends StatefulWidget {
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