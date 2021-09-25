import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Staggered extends StatefulWidget {
  @override
  _StaggeredState createState() => _StaggeredState();
}

class _StaggeredState extends State<Staggered> {
  Material myItems(IconData icon, String heading, int color) => Material(
        color: Colors.white,
        elevation: 25.0,
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
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: <Widget>[
          captionText("Clothes", "International clothes"),
          myPhotoList(
              "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/gh-closet-organization-1583437747.png?crop=0.837xw:0.558xh;0.0847xw,0.245xh&resize=640:*"),

          captionText("Food", "Snacks"),
          myPhotoList(
              "https://civileats.com/wp-content/uploads/2020/09/200917-ultra-processed-foods-big-food-conglomerates-junk-food-health-nutrition-waste-packaging-1-credit-mike-mozart.jpg"),

          captionText("Games", "Tv games"),
          myPhotoList(
              "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/most-popular-video-games-of-2020-1582141293.png"),

          captionText("Sports", "National sports"),
          myPhotoList(
              "https://i.guim.co.uk/img/media/4ea56f78f07886eba24e4c171fe82295ddca8b83/2_0_3021_1814/master/3021.jpg?width=1200&quality=85&auto=format&fit=max&s=34c5d4ac96fc5b8e933ef307539b16b8"),

          captionText("Technology", "Updated technology"),
          myPhotoList(
              "https://www.mining-technology.com/wp-content/uploads/sites/8/2021/03/shutterstock_1837865569-900x506.jpg"),

        ],
        /*
        * myItems(Icons.web_asset_rounded, "Clothes", 0xFFFFAB00),
          myItems(Icons.emoji_food_beverage, "Food", 0xFFFFAB00),
          myItems(Icons.games, "Games", 0xFFFFAB00),
          myItems(Icons.sports, "Sports", 0xFFFFAB00),
          myItems(Icons.biotech, "Technology", 0xFFFFAB00),
        * */
        staggeredTiles: [
          StaggeredTile.extent(2, 90.0),
          StaggeredTile.count(2, 1),

          StaggeredTile.extent(2, 90.0),
          StaggeredTile.count(2, 1),

          StaggeredTile.extent(2, 90.0),
          StaggeredTile.count(2, 1),

          StaggeredTile.extent(2, 90.0),
          StaggeredTile.count(2, 1),

          StaggeredTile.extent(2, 90.0),
          StaggeredTile.count(2, 1),
        ],
      ),
    );
  }
}

Widget myPhotoList(String myImages) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
      fit: BoxFit.fill,
      image: NetworkImage(myImages),
    )),
  );
}

Widget captionText(String titleText, String subText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                titleText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                subText,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
