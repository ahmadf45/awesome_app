import 'package:awesome_app/api/photosApi.dart';
import 'package:awesome_app/models/photoModel.dart';
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
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text(dats[index].id.toString() +
                        ' - ' +
                        dats[index].id.toString()),
                    subtitle: Text(dats[index].photographer),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
