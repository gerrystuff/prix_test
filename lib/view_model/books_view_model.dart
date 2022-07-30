import 'package:books/model/book_model.dart';
import 'package:books/model/domain/full_book.dart';
import 'package:books/model/domain/tile_book.dart';
import 'package:flutter/material.dart';

class BooksViewModel extends ChangeNotifier {
  BookModel bookModel;

  List<TileBook> _tileBooks = [];

  BooksViewModel() : bookModel = BookModel();

  Future<FullBook?> getBook(String workId) async {
    FullBook? book = await bookModel.getBook(workId);
    return book;
  }

  Future<List<TileBook>> getBooks(String name, String filter) async {
    List<TileBook> bookList = await bookModel.getBooks(name, filter);
    setTileBooks(bookList);
    return bookList;
  }

  void setTileBooks(List<TileBook> tileBooks){
    _tileBooks = tileBooks;
  }

  List<TileBook> get tileBooks {
    return _tileBooks;
  }
}
