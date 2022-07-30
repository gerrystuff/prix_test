import 'dart:convert';
import 'dart:io';

import 'package:books/model/domain/full_book.dart';
import 'package:books/model/domain/tile_book.dart';
import 'package:http/http.dart' as http;

class BooksRepository {
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  final String _baseUrl = 'openlibrary.org';

  Future<List<TileBook>> getBooksByName(String name, String filter) async {
    List<TileBook> books = [];

    const String _searchPath = '/search.json';

    final Map<String, String> _queryParameters = <String, String>{
      filter: name,
    };

    try {
      final endpoint = Uri.https(_baseUrl, _searchPath, _queryParameters);

      final resp = await http.get(endpoint, headers: headers);
      final Map<String, dynamic> respMap = json.decode(resp.body);

      final List tempBooks = respMap["docs"];

      // print(tempBooks.toString());

      for (var element in tempBooks) {
        final tempEstacion = TileBook.fromJson(element);
        books.add(tempEstacion);
      }
      return books;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<FullBook?> getBookByWorkId(String workId) async {
   String _searchPath = '$workId.json';

    try {
      final endpoint = Uri.https(_baseUrl, _searchPath);

      print(endpoint);
      final resp = await http.get(endpoint, headers: headers);
      final Map<String, dynamic> respMap = json.decode(resp.body);
    

      final FullBook book = FullBook.fromJson(respMap);

      return book;

    } catch (e) {
      print(e);
      return null;
    }
  }
}
