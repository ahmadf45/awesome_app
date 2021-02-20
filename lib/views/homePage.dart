import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widgets/PhotoGrid.dart';
import '../widgets/PhotoList.dart';
import '../api/photosApi.dart';

class HomePage extends StatefulWidget {
  final String title = "Awesome App";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String view = "grid";
  ScrollController scrollController;
  ScrollNotification notification;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //scrollController.addListener(notification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white.withOpacity(0.5),
              expandedHeight: 200,
              floating: false,
              pinned: true,
              snap: false,
              elevation: 5,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(top: 20),
                background: Image.asset(
                  'lib/images/ww.jpg',
                  fit: BoxFit.cover,
                ),
                centerTitle: true,
                title: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Awesome App",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.grid_view,
                    color: Colors.black,
                    size: 30,
                  ),
                  tooltip: "Grid",
                  onPressed: () {
                    setState(() {
                      view = "grid";
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.view_list,
                    color: Colors.black,
                    size: 30,
                  ),
                  tooltip: "List",
                  onPressed: () {
                    setState(() {
                      view = "list";
                    });
                  },
                ),
              ],
            )
          ];
        },
        body: Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FutureBuilder(
            future: PhotosApi().fetchData(Client(), 1),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                    child: Text(
                  'Please check your internet connection!',
                  style: TextStyle(fontSize: 20),
                  maxLines: 2,
                ));

              return snapshot.hasData
                  ? ((view == "grid")
                      ? PhotoGrid(
                          dats: snapshot.data,
                        )
                      : PhotoList(dats: snapshot.data))
                  : Center(child: CircularProgressIndicator());

              // if (!snapshot.hasData) {
              //   if (snapshot.connectionState == ConnectionState.waiting) {
              //     return Center(child: CircularProgressIndicator());
              //   }
              // } else if (snapshot.hasError) {
              //   return Container(
              //     width: 0.0,
              //     height: 0.0,
              //     child: Center(child: Text('Error Connection!')),
              //   );
              // } else if (view == "grid") {
              //   return PhotoGrid(dats: snapshot.data);
              // } else {
              //   return PhotoList(dats: snapshot.data);
              // }
            },
          ),
        ),
      ),
    );
  }
}
