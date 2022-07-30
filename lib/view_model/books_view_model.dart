import 'package:books/model/domain/full_book.dart';
import 'package:books/model/domain/tile_book.dart';
import 'package:books/repositories/books_repository.dart';
import 'package:flutter/material.dart';

class BooksViewModel extends ChangeNotifier {

  List<TileBook>? _books;
  bool _isLoading = false;
  FullBook? _selectedBook;
  

  bool get loading => _isLoading;

  List<TileBook>? get books {
    return _books;
  }

  setLoading(bool loading) async {
    _isLoading = loading;
  }

  setSelectedBook(FullBook? book){
    _selectedBook = book;
  }

  FullBook? get selectedBook {
    return _selectedBook;
  }


  setBooks(List<TileBook>? books){
    _books = books;
  }

  getBook(String workId) async {
    FullBook? book = await BooksRepository().getBookByWorkId(workId);
    setSelectedBook(book);
  }

  getBooks(String name, String filter) async {
      List<TileBook> bookList = await BooksRepository().getBooksByName(name, filter);
      setBooks(bookList);
  }
}
