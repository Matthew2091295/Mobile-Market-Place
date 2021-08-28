import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Staggered extends StatefulWidget {
  @override
  _StaggeredState createState() => _StaggeredState();
}

class _StaggeredState extends State<Staggered> {
  Material myItems(IconData icon, String heading, int color) => Material(
        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0x802196F3),
        borderRadius: BorderRadius.circular(24.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: new Color(color),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    //Icon
                    Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(206, 166, 97, 1.0),
        title: Text("Market Place"),
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          myItems(Icons.graphic_eq, "TotalViews", 0xFFFFAB00),
          myItems(Icons.bookmark, "Bookmarks", 0xFFFFAB00),
          myItems(Icons.notifications, "Notifications", 0xFFFFAB00),
          myItems(Icons.attach_money, "Balance", 0xFFFFAB00),
          myItems(Icons.settings, "Settings", 0xFFFFAB00),
          myItems(Icons.group_work, "Group Work", 0xFFFFAB00),
          myItems(Icons.message, "Messages", 0xFFFFAB00),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(2, 240.0),
          StaggeredTile.extent(2, 120.0),
        ],
      ),
    );
  }
}
