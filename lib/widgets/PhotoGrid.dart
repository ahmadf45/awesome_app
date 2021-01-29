import 'package:awesome_app/api/photosApi.dart';
import 'package:http/http.dart';

import 'package:awesome_app/models/photoModel.dart';
import 'package:awesome_app/views/detailPage.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final List<Photos> dats;
  PhotoGrid({Key key, this.dats}) : super(key: key);
  @override
  _PhotoGridState createState() => _PhotoGridState(dats);
}

class _PhotoGridState extends State<PhotoGrid> {
  final List<Photos> dats;
  int page = 1;
  ScrollController scrollController = new ScrollController();

  _PhotoGridState(this.dats);

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

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: onNotification,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
        itemCount: dats.length,
        controller: scrollController,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
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
            child: Hero(
              tag: dats[index].src.large,
              child: ClipRRect(
                child: Image.network(dats[index].src.medium, fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }
}
