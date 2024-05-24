import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:library_app/model/books.dart';
import 'package:library_app/model/users.dart';

class DatabaseHelper {
  
  final databaseName = "qdlibrary.db";

  //Now we must create our user table into our sqlite db

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT, usrPassword TEXT)";
  String books =
      "create table books (bookId INTEGER PRIMARY KEY AUTOINCREMENT, bookName TEXT, bookAuthor TEXT, bookAmt INTEGER, pubDate TEXT, bookGenre INTEGER, bookDescript TEXT, language TEXT)";
  String like = 
    "create table likebook (userId INTEGER , bookId INTEGER)";


  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
     try {
      await db.execute(users);
      await db.execute(books);
      await db.execute(like);
    } catch (e) {
      print("Error creating tables: $e");
    }
  });
}
  //Now we create login and sign up method
  //as we create sqlite other functionality in our previous video

  //IF you didn't watch my previous videos, check part 1 and part 2

  //Login Method

  Future<bool> login(Users user) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<void> signup(Users user) async {
    final Database db = await initDB();
    await db.execute("INSERT INTO users(usrName, usrPassword) VALUES('${user.usrName}','${user.usrPassword}')");

  }
  
  Future<bool> uniqueName(Users user) async{
    final Database db = await initDB();
    var result = await db.rawQuery(
      "select * from users where usrName = '${user.usrName}'");
    if (result.isNotEmpty) {
      return false;
    } else {
      return true;
  }

  }
Future<int> findId(Users user) async {
  final Database db = await initDB();

    var result = await db.rawQuery(
      "select usrId from users where usrName = '${user.usrName}'");
    if (result.isNotEmpty) {
      return result.first['usrId'] as int;
    } else {
     
      return 0;
    }
 
  
}




Future<List<Map<String, dynamic>>> getBooksByGenre(int genre) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from books WHERE bookGenre = '$genre'");
   List<Map<String, dynamic>> books = [];
    for (var row in result) {
    books.add({
      "id": row['bookId'],
      "name": row['bookName'],
      "author": row['bookAuthor'],
      "describe": row['bookDescript'], 
      "genre": row['bookGenre'],
      "amount": row['bookAmt'],
      "language": row['Language'],
    });
  }

  

  return books;
  }
  
  Future<List<int>> getLiked(int id) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from likebook WHERE userId = '$id'");
 Future<List<int>>  books = Future.value([]);
    for (var row in result) {
    books.then((list) => list.add(
      row['bookId']as int,
    ));
  }

  return books;
  }
   Future<void> addLiked(int userId, int bookId) async {
    final Database db = await initDB();
    await db.execute("INSERT INTO likebook(userId, bookId ) VALUES('${userId}','${bookId}')");

  }
  Future<void> removeLike(int userId, int bookId) async {
    final Database db = await initDB();
    await db.execute("DELETE FROM likebook WHERE userId = '${userId}' AND bookId = '${bookId}'");

  }




  Future<void> addBook(Books books) async {
    final Database db = await initDB();
    await db.execute("INSERT INTO books(bookName, bookAuthor, bookAmt, pubDate , bookGenre , bookDescript, language) VALUES('${books.bookName}','${books.bookAuthor}','${books.bookAmt}','${books.pubDate}','${books.bookGenre}','${books.bookDescript}','${books.language}')");

  }
  Future<List<Map<String, dynamic>>> getBookslike(int id) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "select * from books WHERE bookGenre = '$id'");
   List<Map<String, dynamic>> books = [];
    for (var row in result) {
    books.add({
      "id": row['bookId'],
      "name": row['bookName'],
      "author": row['bookAuthor'],
      "describe": row['bookDescript'], 
      "genre": row['bookGenre'],
      "amount": row['bookAmt'],
      "language": row['Language'],
    });
  
  }
  return books;
}
}



























