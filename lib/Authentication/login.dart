// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:library_app/Main/main.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Utils.dart';
import 'package:library_app/database/database_helper.dart';
import 'package:library_app/model/users.dart';
import 'package:provider/provider.dart';
class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  

    final style= TextStyle(
                fontFamily: 'Playfair',
                fontSize: 45.0,
                color:Color.fromARGB(255, 58, 18, 18),
                fontWeight: FontWeight.bold,);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('QDHS Library', style: style),
    );
  }
}

class login extends StatefulWidget {
  login({super.key});
  @override
  
  State<login> createState() => _login();
}

class _login extends State<login> {
  final name = TextEditingController();
  final pass = TextEditingController();
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  Future<bool> login(String a, String b) async {
    await Future.delayed(const Duration(seconds: 0));
    var response = await db.login(Users(usrName: a, usrPassword: b));
    if (response == true) {
      setState(() {
        isLoginTrue = true;
      });
    } else if (response == false) {
      setState(() {
        isLoginTrue = false;
      });
    }
    return response;
  }
  Future<int> id(String a, String b) async{
     await Future.delayed(const Duration(seconds: 0));
    var response = await db.findId(Users(usrName: a, usrPassword: b));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    
    final userCredentials = Provider.of<UserCredentials>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 221, 190),
        appBar: AppBar(
           backgroundColor: Color.fromARGB(255, 223, 221, 190),
        // Use the Title widget here
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go('/start'),
        ),
      ),
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 12.0,right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Title(),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Enter your name',
                labelStyle: TextStyle(color: Color.fromARGB(255, 62, 22, 22)),
                 enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 37, 11, 11)), // Change outline color here
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 37, 11, 11)), // Change focused outline color
    ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              
              controller: pass,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                String Nam = name.text;
                String Pas = pass.text;
                isLoginTrue = await login(Nam, Pas);

                if (name.text.isEmpty) {
                  Utils.emptyUsername(context);
                } else if (pass.text.isEmpty) {
                  Utils.emptyPassword(context);
                } else if (isLoginTrue != true) {
                 Utils.incorrectlogin(context);
                } else if (isLoginTrue == true) {
                  isLoginTrue = false;
                  int ids = await id(Nam,Pas);
                  userCredentials.updateAccount(ids, Nam,Pas);
                  print('Username: ${name.text}');
                  print('Password: ${pass.text}');
                  print(ids);
                  Utils.validLogin(context);
                  context.go('/home');
                
                
                }
              },
              child: Text('Login'),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                context.go('/signup');
              },
              child: Text("Don't have an Account?"),
            ),
          ],
        ),
      ),
    ));
  }
}
