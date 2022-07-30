import 'package:books/model/domain/tile_book.dart';
import 'package:flutter/material.dart';

class TileBookWidget extends StatelessWidget {

  final TileBook book;
  const TileBookWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.coverI == 0 ? const Icon(Icons.image_not_supported, size: 40,) :  Image.network('https://covers.openlibrary.org/b/id/${book.coverI}-S.jpg'),
      // trailing:  Text('${book.firstPublishYear}'),
      trailing: const Icon(Icons.info_rounded,color: Color.fromARGB(255, 24, 110, 190),),
      title: Text(book.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
      subtitle: book.authorName.isNotEmpty
          ? Text('${book.authorName[0]} - ${book.firstPublishYear}')
          : const Text('No author.'),
    );
  }
}

//OL14903445W