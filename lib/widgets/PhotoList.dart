import 'package:awesome_app/api/photosApi.dart';
import 'package:awesome_app/models/photoModel.dart';
import 'package:awesome_app/views/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PhotoList extends StatefulWidget {
  final List<Photos> dats;
  PhotoList({Key key, this.dats}) : super(key: key);
  @override
  _PhotoListState createState() => _PhotoListState(dats);
}

class _PhotoListState extends State<PhotoList> {
  final List<Photos> dats;
  int page = 1;
  ScrollController scrollController = new ScrollController();

  bool onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        print('object');
        PhotosApi().fetchData(Client(), page++).then((value) {
          page++;
          setState(() {
            dats.addAll(value);
          });
        });
      }
    }
    return true;
  }

  _PhotoListState(this.dats);
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        itemCount: dats.length,
        itemBuilder: (context, index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(
                            large: dats[index].src.large,
                            photographer: dats[index].photographer,
                            photographerUrl: dats[index].photographerUrl,
                          )),
                );
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Hero(
                            tag: dats[index].src.large,
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.network(dats[index].src.medium,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(dats[index].id.toString() + ' - '),
                          Text(dats[index].photographer)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
