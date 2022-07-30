import 'package:books/model/domain/tile_book.dart';
import 'package:books/view_model/books_view_model.dart';
import 'package:books/widgets/full_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  final TileBook tileBook;

  const BookDetailScreen({Key? key, required this.tileBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BooksViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        bookViewModel.setSelectedBook(null);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title:  Text('${tileBook.title} Book'),
          backgroundColor: Colors.brown,
        ),
        body: FutureBuilder(
          future: bookViewModel.getBook(tileBook.key),
          builder: (_, AsyncSnapshot snapshot) {
            if (bookViewModel.selectedBook != null) {
              return FullBookWidget(book: bookViewModel.selectedBook,author: tileBook.authorName[0],);
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                strokeWidth: 4,
              ));
            }
          },
        ),
      ),
    );
  }
}
