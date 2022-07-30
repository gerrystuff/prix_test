import '../repositories/books_repository.dart';
import 'domain/full_book.dart';
import 'domain/tile_book.dart';

class BookModel {
  Future<FullBook?> getBook(String workId) async {
    FullBook? book = await BooksRepository().getBookByWorkId(workId);
    return book;
  }

  Future<List<TileBook>> getBooks(String name, String filter) async {
    List<TileBook> bookList =
        await BooksRepository().getBooksByName(name, filter);
    return bookList;
  }
}
