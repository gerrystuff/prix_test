import 'package:books/model/domain/full_book.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';

class FullBookWidget extends StatelessWidget {
  final FullBook? book;
  final String author;
  const FullBookWidget({Key? key, required this.book, required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    getCoverPhotos(List photos) {
      List covers = [];

      for (var i = 0; i < photos.length; i++) {
        if (photos[i] != -1) {
          covers.add(photos[i]);
        }
      }

      return covers;
    }

    getCoverCarouselSlider() {
      return book!.covers.isEmpty
          ? Image.asset('assets/images/no-image.jpg')
          : CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
                height: 500,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: getCoverPhotos(book!.covers).map((cover) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        child: FadeInImage(
                          placeholder:
                              const AssetImage("assets/images/loading_gif.gif"),
                          image: NetworkImage(
                              'https://covers.openlibrary.org/b/id/$cover-L.jpg'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
    }

    return SingleChildScrollView(
      child: Container(
        padding: const  EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getCoverCarouselSlider(),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(
                  author,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(getPublishDate(book!.firstPublishDate),
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            Text(getDescription(book!.description),
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16)),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 5),
            
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: getSubjects(book!.subjects),
            ),
          ],
        ),
      ),
    );
  }

  getSubjects(List<String> items) {

    List<String> itemsFixed = items.where((item) => item.length < 50).toList();

    return SimpleTags(
        content: itemsFixed,
        wrapSpacing: 4,
        wrapVerticalDirection: VerticalDirection.down,
        wrapRunSpacing: 4,
        tagContainerPadding: const EdgeInsets.all(6),
        tagTextStyle: const TextStyle(color: Color.fromARGB(255, 57, 69, 238)),
        tagContainerDecoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(40, 28, 149, 10),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1.75, 3.5), // c
            )
          ],
        ),
      );

    // return Tags(  
    //   itemCount: items.length, 
    //   itemBuilder: (int index){ 
    //       return Tooltip(
    //       message: items[index],
    //       child:ItemTags(
    //         title:items[index]
    //       )
    //       );
    //   },
    // );    
    // return ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: subjects.length,
    //     physics: const NeverScrollableScrollPhysics(),
    //     itemBuilder: ((context, index) => ListTile(
    //           title: Text(subjects[index]),
    //         )));
    // return ListView.separated(
    //           itemCount: book!.subjects.length,
    //           itemBuilder: ((context, index) => ListTile(title: Text(book!.subjects[index] ))),
    //           separatorBuilder: (BuildContext context, int index) {
    //             return const Divider();
    //            });
  }

  String getPublishDate(String? publishDate) {
    if (publishDate == null) {
      return 'No publish date';
    }
    return publishDate;
  }

  String getDescription(dynamic description) {
    print(description);
    if (description is String) {
      return description;
    }

    if (description == null) {
      return 'No description';
    }

    return description['value'];
  }
}
