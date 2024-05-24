import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';



class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text('QDHS Library', style: style),
    );
  }
}
class Utils {
   static ButtonStyle style =  ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 251, 248, 224),
      foregroundColor: Color.fromARGB(255, 130, 38, 38) // Set your button color here
    );
  static void shortpassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Password'),
        content: Text('Your Password Need to be Longer Than 6 Letters'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void emptyUsername(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Username'),
        content: Text('Please Input Your Username'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
    static void emptyPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Password'),
        content: Text('Please Input Your Password'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void confirmerror(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Verification'),
        content: Text('Please Write Same Password In Your Confirm'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void incorrectlogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Login'),
        content: Text('Username or Password Wrong'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void signupconfirm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Valid Signup'),
        content: Text('Sign Up Successfully'),
        actions: [
          TextButton(
            onPressed: () {
                
                Navigator.pop(context);
                context.go("/login");
            },
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void repeatName(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Signup'),
        content: Text('Username Existed'),
        actions: [
          TextButton(
            onPressed: () {
                
                Navigator.pop(context);
              
            },
            child: Text('OK'),
            style: style,
          ),
        ],
      ),
    );
  }
  static void validLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Valid Login'),
        content: Text('Login Successful'),
        actions: [
          TextButton(
            onPressed: () {
                
                Navigator.pop(context);
              
            },
            child: Text('OK'),
            style: style,

          ),
        ],
      ),
    );
  }
    static void specialSymbol(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Password'),
        content: Text("Please Don't include Special Symbles"),
        actions: [
          TextButton(
            onPressed: () {
                
                Navigator.pop(context);
              
            },
            child: Text('OK'),
            style: style,

          ),
        ],
      ),
    );
  }
      
}