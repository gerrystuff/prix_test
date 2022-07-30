import 'package:books/view/book_search_screen.dart';
import 'package:books/view/form_screen.dart';
import 'package:books/view/user_screen.dart';
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
              const Text('Prix Test',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              Divider(),
              MaterialButton(
                
                child: const Text('Books', style: TextStyle(color: Colors.black),),
                shape: const StadiumBorder(),
                color: Colors.white,
                elevation:4,
                splashColor: Colors.transparent,
                onPressed: () async {
                  await showSearch(
                      context: context, 
                      delegate: BooksSearchDelegate()
                      );

                },
              ),

              MaterialButton(
                child: const Text('Form', style: TextStyle(color: Colors.black),),
                shape: const StadiumBorder(),
                color: Colors.white,
                elevation:5,
                splashColor: Colors.transparent,
                onPressed: ()  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const FormScreen()));

                },
              ),

                     MaterialButton(
                child: const Text('User info', style: TextStyle(color: Colors.black),),
                shape: const StadiumBorder(),
                color: Colors.white,
                elevation:5,
                splashColor: Colors.transparent,
                onPressed: ()  {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  const UserScreen()));

                },
              ),
              
            ],
          ),
        ));
  }
}
