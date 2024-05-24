import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Main/main.dart';
import 'package:provider/provider.dart';

class GenrePage extends StatefulWidget {
  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  
  final List<String> genres = [
    'Science Fiction',
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

    final List<String> discript = [
      '',
      '',

    ];
  bool isSearchActive = false;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {

   
    final style = TextStyle(
                fontFamily: 'Playfair',
                fontSize: 40.0,
                color: Color.fromARGB(255, 255, 246, 222),
                fontWeight: FontWeight.bold,
    );
  

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 242, 205),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 68, 12, 12),
        title:Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child:Text('Genres', style:style
        
    ),),
    leading: IconButton(
      color: Color.fromARGB(255, 255, 246, 222),
          icon: const Icon(Icons.arrow_back_ios_new), 
          
          onPressed: () { 
            context.go('/home');
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
            color: Color.fromARGB(255, 255, 246, 222),
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
      body: Stack(
        
        children: [
          Padding(
             padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            child:AnimatedList(
            
              initialItemCount: genres.length,
              itemBuilder: (context, index, animation) {
                
                final genre = genres[index];
                return SlideTransition(
                  
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: isSearchActive ? Offset(0, 0.3) : Offset.zero,
                  ).animate(animation),
                  child: Visibility(
                    visible: !isSearchActive || genre.toLowerCase().contains(searchQuery.toLowerCase()),
                    child: GenreCard(
                      genre: genre,
                      onTap: () => navigateToGenrePage(genre),
                    ),
                  ),
                );
              },
            ),),
            if (isSearchActive)
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: kToolbarHeight,
                  color: Color.fromARGB(255, 252, 242, 205),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 5.0,left: 7.0,right: 7.0),
                  child: TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: const InputDecoration(
                      hintText: 'Search Genres...',
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

  void navigateToGenrePage(String genre) {
 UserCredentials userCredentials = Provider.of<UserCredentials>(context, listen: false);
 int index = genres.indexOf(genre);
 userCredentials.updateGenre(index);
    context.go('/books');
  }
}

class GenreCard extends StatelessWidget {
  final String genre;
  final VoidCallback onTap;

  const GenreCard({Key? key, required this.genre, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final genrestyle = TextStyle(
               
                fontFamily: 'Genretab',
                fontSize: 30.0,
                color: Color.fromARGB(255, 39, 38, 38),
                fontWeight: FontWeight.bold,
    );
    return Card(
       margin: EdgeInsets.only(top:15.0,bottom: 10.0),
      color: Color.fromARGB(255, 255, 246, 222),
   
      child: InkWell(
      
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(genre, style: genrestyle),
        ),
      ),
    );
  }
}