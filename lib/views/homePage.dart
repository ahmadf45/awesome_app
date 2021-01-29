import 'package:flutter/material.dart';
import '../models/photoModel.dart';
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

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
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
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(top: 20),
                background: Image.asset(
                  'lib/images/projectbg.jpg',
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
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? ((view == "grid")
                      ? PhotoGrid(dats: snapshot.data)
                      : PhotoList(dats: snapshot.data))
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

// class PG extends StatelessWidget {
//   final List<Photos> dats;
//   int page = 1;
//   ScrollController scrollController = new ScrollController();

//   bool onNotification(ScrollNotification notification) {
//     if (notification is ScrollUpdateNotification) {
//       if (scrollController.position.maxScrollExtent > scrollController.offset &&
//           scrollController.position.maxScrollExtent - scrollController.offset <=
//               50) {
//         print('object');
//         PhotosApi().fetchData(Client(), page + 1).then((value) {
//           // page = page + 1;
//         });
//       }
//     }
//     return true;
//   }

//   PG({Key key, this.dats}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener(
//       onNotification: onNotification,
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, crossAxisSpacing: 15.0, mainAxisSpacing: 15.0),
//         itemCount: dats.length,
//         controller: scrollController,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => DetailPage(
//                           medium: dats[index].src.medium,
//                           photographer: dats[index].photographer,
//                           photographerUrl: dats[index].photographerUrl,
//                         )),
//               );
//             },
//             child: Hero(
//               tag: dats[index].src.medium,
//               child: ClipRRect(
//                 child: Image.network(dats[index].src.small, fit: BoxFit.cover),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ll extends StatelessWidget {
  final List<Photos> dats;

  ll({Key key, this.dats}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
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
    );
  }
}
