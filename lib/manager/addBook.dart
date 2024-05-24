import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/database/database_helper.dart';
import 'package:library_app/model/books.dart';
import 'package:library_app/Utils.dart';
class addBook extends StatelessWidget{
  const addBook({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      
        title: 'library_app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: addBooks());
      
    
  }}
class addBooks extends StatelessWidget {
  final name = TextEditingController();
  final author = TextEditingController();
  final amt =  TextEditingController();
  final pub = TextEditingController();
  final genre =  TextEditingController();
  final des = TextEditingController();
  final lang = TextEditingController();
  
    addbook() async {
    final db = DatabaseHelper();
    await db.addBook(
        Books(bookName: name.text, bookAuthor: author.text, bookAmt: amt.text, pubDate: pub.text, bookGenre: genre.text, bookDescript: des.text, language: lang.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 197, 154),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Title(),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                labelText: 'Enter book name',
              ),
            ),TextFormField(
              controller: author,
              decoration: InputDecoration(
                labelText: 'Enter author name',
              ),
            ),TextFormField(
              controller: genre,
              decoration: InputDecoration(
                labelText: 'Enter book Genre',
              ),
            ),TextFormField(
              controller: amt,
              decoration: InputDecoration(
                labelText: 'How many have bought?',
              ),
            ),TextFormField(
              controller: pub,
              decoration: InputDecoration(
                labelText: 'Publish Date',
              ),
            ),TextFormField(
              controller: des,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),TextFormField(
              controller: lang,
              decoration: InputDecoration(
                labelText: 'Book Language',
              ),
            ),
           ElevatedButton(
              onPressed:() {
                addbook();
                Utils.validLogin(context);
               
                }

            , child: Text('Add Book')
          ), ElevatedButton(
              onPressed:(){
                context.go("/manage");
                }

            , child: Text('Back')
          ),
           
          ],
        ),
      ),
    );
  }
  }
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