import 'package:books/model/domain/tile_book.dart';
import 'package:books/view/book_detail_screen.dart';
import 'package:books/view_model/books_view_model.dart';
import 'package:books/widgets/tail_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksSearchDelegate extends SearchDelegate<TileBook?> {
  bool _searchByName = true;
  bool _searchByAuthor = false;


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty || getFilter() == '') {
      return const Center(
        child: Text('Choose a filter', style: TextStyle(fontSize: 20),),
      );
    }

    BooksViewModel bookViewModel = Provider.of<BooksViewModel>(context);

    bookViewModel.setBooks(null);

    return FutureBuilder(
      future: bookViewModel.getBooks(query.trim(),getFilter()),
      builder: (_, AsyncSnapshot snapshot) {
        if (bookViewModel.books != null) {
          return _showBooks(bookViewModel.books);
        } else {
          return const Center(
              child: CircularProgressIndicator(
            strokeWidth: 4,
          ));
        }
      },
    );

    // print(query);
    // return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sb = StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Search by name',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              value: _searchByName,
              onChanged: (value) => {
                setState(() {
                  _searchByName = value;
                })
              },
            ),

             SwitchListTile(
              title: const Text('Search by author',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              value: _searchByAuthor,
              onChanged: (value) => {
                setState(() {
                  _searchByAuthor = value;
                })
              },
            ),
          ],
        ),
      );
    });

    return sb;
  }

  Widget _showBooks(List<TileBook>? books) {
    return ListView.builder(
      itemCount: books!.length,
      itemBuilder: (context, i) {
        return GestureDetector(
            child: TileBookWidget(book: books[i]),
            onTap: (){

              Navigator.push(context,MaterialPageRoute(builder: (context) =>  BookDetailScreen(tileBook: books[i],)));
            });
      },
    );
  }


  String getFilter(){
    if(_searchByAuthor && _searchByName) {
      return 'q';
    }
    
    if(_searchByName) {
      return 'title';
    }
    
    if(_searchByAuthor) {
      return 'author';
    }

    return '';
  }
}
