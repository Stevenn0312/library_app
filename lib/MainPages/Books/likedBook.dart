import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/database/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:library_app/Main/main.dart';

class likedBooks extends StatefulWidget {
  @override
  likeBooks createState() => likeBooks();
}

class likeBooks extends State<likedBooks> {
  final db = DatabaseHelper();
  List<Map<String, dynamic>> _books = [

  ];

  bool isSearchActive = false;
  String searchQuery = "";
  List<int> likedBookIds = [];
  @override
  void initState() {
    super.initState();
    _getBooks();
    _getLikedBooks();
  }
void _getLikedBooks() async {
    final userCredentials = Provider.of<UserCredentials>(context, listen: false);
    likedBookIds = await db.getLiked(userCredentials.userId); // Call database function
    setState(() {}); // Trigger a rebuild to update likedBookIds in the UI
  }
  void _getBooks() async {
    final userCredentials =
        Provider.of<UserCredentials>(context, listen: false);
    Future.delayed(const Duration(seconds: 0));
    var books = await db.getBookslike(userCredentials.genre);
    setState(() {
      _books = books;
    });
  }
  
  void _toggleLike(int bookId) async {
    final userCredentials = Provider.of<UserCredentials>(context, listen: false);
    if (likedBookIds.contains(bookId)) {
      await db.removeLike(userCredentials.userId, bookId);
      likedBookIds.remove(bookId);
    } else {
      await db.addLiked(userCredentials.userId, bookId);
      likedBookIds.add(bookId);
    }
    // No need to rebuild all widgets, setState only updates this widget
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 242, 205),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 68, 12, 12),
        centerTitle: true,
       
        title: Text('Favorite Books',
            style: TextStyle(
              fontFamily: 'Playfair',
              fontSize: 40.0,
              color: Color.fromARGB(255, 255, 246, 222),
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          color: Color.fromARGB(255, 255, 246, 222),
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              back();
              
            } 
            ),
             shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0)
          )
        ),
        actions: [
          IconButton(
              color: Color.fromARGB(255, 255, 255, 253),
            icon: Icon(isSearchActive ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearchActive = !isSearchActive;
                searchQuery = ""; // Reset search query on close
              });
            },
          ),
        ],
      ),
      body: _books.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                AnimatedList(
                  initialItemCount: _books.length,
                  itemBuilder: (context, index, animation) {
                    final book = _books[index];
                    String name = book['name'];
                     int bookId = book['id'];
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: isSearchActive ? Offset(0, 0.5) : Offset.zero,
                      ).animate(animation),
                      child: Visibility(
                          visible: !isSearchActive ||
                              book['name']
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()),
                          child: BookCard(
                            bookName: book['name'],
                            bookAuthor: book['author'],
                            bookDescription: book['describe'],
                            onTap: () {
                            print(name);
                            showDialog(
                              context: context, // Pass theBuildContext here
                              builder: (context) => AlertDialog(
                                title: Text('Book chosed'),
                                content: Text("$bookId chosed"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                            },
                            onFavorite:  () => _toggleLike(bookId), // Call _toggleLike with bookId
                            isLiked: likedBookIds.contains(bookId),
                            
                          )),
                    );
                  },
                ),
                if (isSearchActive)
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: kToolbarHeight,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 2.0, bottom: 5.0, left: 7.0, right: 7.0),
                        child: TextField(
                          onChanged: (value) =>
                              setState(() => searchQuery = value),
                          decoration: const InputDecoration(
                            hintText: 'Search Books...',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 58, 40, 40)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  void back() {
    UserCredentials userCredentials =
        Provider.of<UserCredentials>(context, listen: false);
    userCredentials.updateGenre(-1);
    context.go('/home');
  }
}
bool isFavorite = false;


class BookCard extends StatelessWidget {
  final String bookName;
  final String bookAuthor;
  final String bookDescription;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
     final bool isLiked; 
// Callback for favoriting a book
  const BookCard({
    Key? key,
    required this.bookName,
    required this.bookAuthor,
    required this.bookDescription,
    required this.onTap,
    required this.onFavorite,
     required this.isLiked, 
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String des = "";
    if (bookDescription.length > 20) {
      des = bookDescription.trim().substring(0, 20) + "...";
    } else {
      des = bookDescription;
    }

    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('by $bookAuthor'),
                  const SizedBox(height: 8.0),
                  Text(des),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              color: isLiked ? Colors.pink : Colors.grey, // Set color based on isLiked
              onPressed: () async{
              onFavorite(); 
              }
            ),
          ],
        ),
      ),
    );
  }
}