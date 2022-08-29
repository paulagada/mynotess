import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotess/constant/routes.dart';
import 'package:mynotess/firebase_options.dart';
import 'package:mynotess/views/Register_view.dart';
import 'package:mynotess/views/Verify_email_view.dart';
import 'package:mynotess/views/login_view.dart';
import 'dart:developer' as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Homepage(),
      routes: {
        loginRoute:(context) => const Loginview(),
        registerRoute:(context) => const Registerview(),
        notesRoute:(context) => const Noteview()
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
           final user = FirebaseAuth.instance.currentUser;
           if (user != null) {
            if (user.emailVerified) {
              return const Noteview();
            }else {
              return const verifyEmailview();
            }
           }else {
            return const Loginview();
           }
           
          default:
        return const CircularProgressIndicator();
        }
          
        },
      );
  }
}

enum MenuAction {logout}

class Noteview extends StatefulWidget {
  const Noteview({Key? key}) : super(key: key);

  @override
  State<Noteview> createState() => _NoteviewState();
}

class _NoteviewState extends State<Noteview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async{
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, 
                  (_) => false,
                  );
                }
                break;
            }
          },itemBuilder: (context) {
            return const [
            PopupMenuItem<MenuAction>( value: MenuAction.logout,
            child: Text('Log out'),)
        ];},)
        ],
      ),
      body: const Text('Hello world'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
 return showDialog<bool>(
    context: context,
     builder: (context) {
       return AlertDialog(
        title: const Text('sigh out'),
        content: const Text('Are you sure u want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            }, 
            child: const Text('cancel'),
            ),
            TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            }, 
            child: const Text('Log out'),
            ),
        ],
       );
     },).then((value) => value ?? false);
}