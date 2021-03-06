import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final String large;
  final String photographer;
  final String photographerUrl;

  DetailPage({
    Key key,
    @required this.large,
    this.photographer,
    this.photographerUrl,
  }) : super(key: key);

  urlLauncher() async {
    if (await canLaunch(photographerUrl)) {
      await launch(photographerUrl);
    } else {
      throw 'Cound not launc $photographerUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Detail"),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
              transitionOnUserGestures: true,
              tag: large,
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(16.0),
              //   child: Image.network(medium, fit: BoxFit.cover),
              // ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.hue),
                      image: NetworkImage(large),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        photographer,
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (await canLaunch(photographerUrl)) {
                            await launch(photographerUrl);
                          } else {
                            throw 'Cound not launc $photographerUrl';
                          }
                        },
                        icon: Icon(Icons.send),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
