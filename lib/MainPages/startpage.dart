import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class startpage extends StatelessWidget{
  const startpage({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData myCustomTheme = ThemeData(
     
  inputDecorationTheme: InputDecorationTheme(
  
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 37, 11, 11)), // Change outline color here
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 37, 11, 11)), // Change focused outline color
    ),
    labelStyle: TextStyle(color: const Color.fromARGB(255, 65, 34, 34)), // Set your label text color
    
    
  ),
    elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 243, 241, 223),
      foregroundColor: Color.fromARGB(255, 101, 28, 28) // Set your button color here
    ),
  ),
  
);
    return MaterialApp(

      
        title: 'library_app',
        theme:myCustomTheme,
        home: Start(),
      );
    
  }}
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
  class Start extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
  
      return Scaffold(
         backgroundColor: Color.fromARGB(255, 223, 221, 190),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Title(),
              ],
            ),
            Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
              onPressed:(){
                context.go("/login");
                }

            , child: Text('Student')
          ),
          SizedBox(width: 30.0,),
            ElevatedButton(
              onPressed: () {
                context.go("/manage");
              },
              child: Text('Manage'),
            ),
              ],
            ),
          ],
        ),
      );
  }
}

