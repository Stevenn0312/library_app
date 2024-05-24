import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_app/Authentication/login.dart';
import 'package:library_app/MainPages/Books/likedBook.dart';
import 'package:library_app/MainPages/Genres/GenrePage.dart';
import 'package:library_app/MainPages/Books/booksByGenre.dart';
import 'package:library_app/MainPages/Home/home.dart';
import 'package:library_app/manager/addBook.dart';
import 'package:library_app/manager/manage.dart';
import 'package:library_app/MainPages/startpage.dart';
import 'package:library_app/Authentication/signup.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/errorpage.dart';
import 'package:provider/provider.dart';

class UserCredentials with ChangeNotifier {
  String username = '';
  int userId = -1;
  String userPass = '';
  int genre = -1;
  List<String> genres = [ 'Science Fiction',
    'Non-Fiction',
    'Fantasy',
    'Mystery',
    'Romantic',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
];
String searchText = '';

  void updateCredentials(String newUsername, int newUserId, String newPassword, List<String> genres) {
    username = newUsername;
    userId = newUserId;
    userPass = newPassword;
    genres = genres;
    notifyListeners(); // Notify listeners of changes
  }
  void updateGenre(int genre){
    this.genre =genre;
  }
  void updateAccount(int id, String name, String pas){
    userId = id;
    username = name;
   userPass = pas;
  }
  void updateSearch(String search){
    searchText = search;
  }
}void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
   runApp(
    
  ChangeNotifierProvider(
  create: (context) => UserCredentials(),
  child: MyApp()
  ),
);}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  
  Widget build(BuildContext context) {
    
    ThemeData myCustomTheme = ThemeData(
      useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
      seedColor: Color.fromARGB(255, 255, 249, 200),
    
      brightness: Brightness.light,
    ),
      cardColor: Color.fromARGB(255, 255, 232, 185),
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
      backgroundColor: Color.fromARGB(255, 251, 248, 224),
      foregroundColor: Color.fromARGB(255, 109, 34, 34) // Set your button color here
    ),
  ),
  
);
    return MaterialApp.router(
      title: 'Go Router',
      routerConfig: router,
      
      theme: myCustomTheme,
      
        
    );
  }
}
 final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes:[
      GoRoute(path: '/start',builder: (context, state) => startpage(),),
      GoRoute(path: '/login',builder: (context, state) =>  login(),),   
      GoRoute(path: '/signup',builder: (context, state) => signup(),),
      GoRoute(path: '/manage',builder: (context, state) => managepage(),),
      GoRoute(path: '/addBooks',builder: (context, state) => addBook(),),
      GoRoute(path: '/genre',builder: (context, state) => GenrePage(),),
      GoRoute(path: '/books',builder: (context, state) => Books(),),
      GoRoute(path: '/home',builder: (context, state) => home(),),
      GoRoute(path: '/like',builder: (context, state) => likedBooks(),),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(child: ErrorPage());
    },
    
    );
 
   