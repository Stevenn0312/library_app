import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:library_app/Main/main.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  @override
  homepage createState() => homepage();
}

class homepage extends State<home> {
  bool _isSearching = false;
  final TextEditingController _searchTextController = TextEditingController();
  bool _isExpanded = false;
  final List<String> buttonTitles = ['Genre', 'Author', 'Language'];
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      _searchTextController.text = ''; // Clear text field on close
    });
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'Playfair',
      fontSize: 40.0,
      color: Color.fromARGB(255, 255, 246, 222),
      fontWeight: FontWeight.bold,
    );

    UserCredentials userCredentials = Provider.of<UserCredentials>(context);

    return MaterialApp(
        theme: Theme.of(context),
        home: Scaffold(
          
          backgroundColor: Color.fromARGB(255, 244, 244, 206),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 68, 12, 12),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('Hi, ${userCredentials.username}', style: style),
            ),
            leading: Row(children: [
              IconButton(
                  color: Color.fromARGB(255, 255, 246, 222),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Provider.of<UserCredentials>(context, listen: false);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Log Out?'),
                        content: Text("Sure to Log Out?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              userCredentials.updateAccount(-1, '', '');
                              context.go('/login');
                            },
                            child: Text('OK'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 246, 222),
                                foregroundColor: Color.fromARGB(255, 130, 38,
                                    38) // Set your button color here
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                   Color.fromARGB(255, 255, 246, 222),
                                foregroundColor: Color.fromARGB(255, 90, 90,
                                    90) // Set your button color here
                                ),
                          ),
                        ],
                      ),
                    );
                  }),
            ]),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))),
            actions: [
              Theme(
             data:   ThemeData(
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
  ),),
  
              child:PopupMenuButton<String>(
                child: TextButton(
                  onPressed: null, // Remove default onPressed behavior
                  child: Text("Browse",
                      style: TextStyle(color: Color.fromARGB(255, 255, 246, 222), fontSize: 20)),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor:
                        Color.fromARGB(255, 68, 12, 12), // Button color
                    shape: const RoundedRectangleBorder(// Rectangular shape
                        // Optional border
                        ),
                  ),
                ),
                onSelected: (value) {
                  context.go('/${value.toLowerCase()}');
                },
                itemBuilder: (context) => buttonTitles
                    .map((title) => PopupMenuItem<String>(
                          value: title,
                          child: Text(title,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 151, 46, 38))),
                        ))
                    .toList(),
              ),),
              if (_isSearching)
                IconButton(
                  color: Color.fromARGB(255, 255, 246, 222),
                  icon: const Icon(Icons.close),
                  onPressed: _toggleSearch,
                ),
              if (!_isSearching)
                IconButton(
                  color: Color.fromARGB(255, 255, 246, 222),
                  icon: const Icon(Icons.search),
                  onPressed: _toggleSearch,
                ),
              if (_isSearching)
                Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 8.0),
                    child: Row(children: [
                      SizedBox(
                        width: 200.0,
                        child: TextField(
                          controller: _searchTextController,
                          decoration: const InputDecoration(
                              fillColor: Colors.white, // Example color
                              filled: true,
                              hintText: 'Search'),
                          onSubmitted: (text) {
                            // Logic to store search text can be implemented here
                            print('Search text: $text');
                            _toggleSearch();
                          },
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(
                            Icons.check), // You can choose a different icon
                        onPressed: () {
                          // Implement logic to store the search text here
                          final searchText = _searchTextController.text;
                          // ... store searchText ...
                          print('Search text to store: $searchText');
                          // Clear the text field after storing
                          _searchTextController.text = '';
                          navigateToSearch(searchText);
                        },
                      ),
                    ])),
            ],
          ),
        
         body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 150.0, // Adjust container height as needed
      decoration: BoxDecoration(
        color: Colors.white, // Scrollable section background color
        borderRadius: BorderRadius.circular(8.0), // Optional rounded corners
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Card(
            child: InkWell(
              
              onTap: () {
                context.go('/like');
              },
              child: Padding(
                
                padding: const EdgeInsets.all(10.0),
                child:Row(
crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  
                    Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 110, 19, 13),
               size: 30.0,
              semanticLabel: 'Favorite books',
    ),
    SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
            Text(
              'Favorite Books',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8.0),
            Text('Manage or Read'),
             const SizedBox(height: 8.0),
            Text('Your Liked Books'),  // Limit description length
          ],
              
                )

                ]
                )
              ),
            ),
          ),
           Card(
            child: InkWell(
              
              onTap: () {
               
              },
              child: Padding(
                
                padding: const EdgeInsets.all(10.0),
                child:Row(
crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  
                    Icon(
              Icons.book,
              color: Color.fromARGB(255, 110, 19, 13),
               size: 30.0,
              semanticLabel: 'Favorite books',
    ),
    SizedBox(width: 10.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                   
            Text(
              'Borrowed Books',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8.0),
            Text('Check the books'),
             const SizedBox(height: 8.0),
            Text('You\'ve borrowed'),  // Limit description length
          ],
              
                )

                ]
                )
              ),
            ),
          ),
          // Add more cards here
        ],
      ),
    ),
  ),
        ));
  }

  void navigateToSearch(String genre) {
    UserCredentials userCredentials =
        Provider.of<UserCredentials>(context, listen: false);
    userCredentials.updateSearch(genre);
    context.go('/searchBooks');
  }
}
