import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class managepage extends StatelessWidget{
  const managepage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      
        title: 'library_app',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: manage());
      
    
  }}
class manage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Title(),
            ElevatedButton(
              onPressed:(){
                context.go("/addBooks");
                }

            , child: Text('Add Book')
          ),
          ElevatedButton(
              onPressed:(){
                context.go("/start");
                }

            , child: Text('Back')
          ),
            // ← Example change.
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