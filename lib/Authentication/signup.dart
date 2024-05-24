
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Utils.dart';

import 'package:library_app/database/database_helper.dart';
import 'package:library_app/model/users.dart';

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

class signup extends StatefulWidget {
  const signup({super.key});
  @override
  State<signup> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<signup> {
  final namecontrol = TextEditingController();
  final passwordcontrol = TextEditingController();
  final confirmcontrol = TextEditingController();
  bool repeat = false;
  final db = DatabaseHelper();
  bool isVisible = false;
  Color infocolor = Color.fromARGB(255, 230, 227, 177);


  String getStrength() {
    if (passwordcontrol.text.length < 6 && passwordcontrol.text.isNotEmpty) {
     

      return "Weak password";
    } else if (passwordcontrol.text.length < 9 &&
        passwordcontrol.text.length >= 6) {
     

      return "Medium password";
    } else {
      

      return "Strong password";
    }
  }

  Future<bool> unique(String a, String b) async {
    await Future.delayed(const Duration(seconds: 0));
    var response = await db.uniqueName(Users(usrName: a, usrPassword: b));
    if (response == true) {
      setState(() {
        repeat = false;
      });
    } else if (response == false) {
      setState(() {
        repeat = true;
      });
    }
    return response;
  }

  signups() async {
    final db = DatabaseHelper();
    await db.signup(
        Users(usrName: namecontrol.text, usrPassword: passwordcontrol.text));
  }

  @override
  Widget build(BuildContext context) {
    bool hasSpecialChars(String str) {
  for (int i = 0; i < str.length; i++) {
    int charCode = str.codeUnitAt(i);
    if (charCode >= 33 && charCode <= 47 || // ASCII for punctuation marks
        charCode >= 58 && charCode <= 64 || // ASCII for some symbols
        charCode >= 91 && charCode <= 96 || // ASCII for other symbols
        charCode >= 123 && charCode <= 126) {
      return true;
    }
  }
  return false;
}
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 221, 190),
      body: Padding(
        padding: EdgeInsets.only(top:8.0,bottom: 8.0,left: 12.0,right: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Approach 1: Set alignment in inspector
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            Title(),
            TextFormField(
              controller: namecontrol,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordcontrol,
              obscureText: !isVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(isVisible
                          ? Icons.visibility
                          : Icons.visibility_off))),
             onChanged: (String value) {
              setState(() {
                if(value.length<6) {
                  infocolor = Colors.red;
                  getStrength();
                }else if(value.length<9){
                  infocolor = Colors.orange;
                  getStrength();

                }else{
                  infocolor = Colors.green;
                  getStrength();
                }
                  });
                  },
            
            ),
      Align(
      alignment: Alignment.topLeft,
      child: 
            Builder(
        
 
    
              
              builder: (context) => Text(
                
                getStrength(),
                style: TextStyle(
                    color: passwordcontrol.text.isEmpty
                        ? Color.fromARGB(255, 230, 227, 177)
                        : infocolor),
              ),
            ),),
           
            TextFormField(
              controller: confirmcontrol,
              obscureText: !isVisible,
              decoration: InputDecoration(
                  labelText: 'Confirm your Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(isVisible
                          ? Icons.visibility
                          : Icons.visibility_off))),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                String nameC = namecontrol.text.replaceAll("'", "\\'");
                String passwordC = passwordcontrol.text;
                String confirm = confirmcontrol.text;
                bool isUnique = await unique(nameC, passwordC);
                setState(() {
                  repeat =
                      !isUnique; // Set repeat based on the returned value (opposite of uniqueness)
                });

                if (nameC.isEmpty) {
                  Utils.emptyUsername(context);
                  
                } else if (passwordC.length < 4) {
                  Utils.shortpassword(context);
                } else if (passwordC != confirm) {
                  Utils.confirmerror(context);
                } else if (repeat) {
                  Utils.repeatName(context);
                }else if(hasSpecialChars(passwordC)){
                  Utils.specialSymbol(context);
                } else {
                  repeat = false;
                  signups();

                Utils.signupconfirm(context);
                }

                // Validate form and handle sign up logic here
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
