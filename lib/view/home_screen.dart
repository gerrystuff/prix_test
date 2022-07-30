import 'package:books/view/book_search_screen.dart';
import 'package:books/view/form_screen.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: const Text('Books', style: TextStyle(color: Colors.white),),
                shape: const StadiumBorder(),
                color: Colors.blue,
                elevation:0,
                splashColor: Colors.transparent,
                onPressed: () async {
                  await showSearch(
                      context: context, 
                      delegate: BooksSearchDelegate()
                      );

                },
              ),

              MaterialButton(
                child: const Text('Form', style: TextStyle(color: Colors.white),),
                shape: const StadiumBorder(),
                color: Colors.blue,
                elevation:0,
                splashColor: Colors.transparent,
                onPressed: ()  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  FormScreen()));

                },
              ),
              
            ],
          ),
        ));
  }
}
