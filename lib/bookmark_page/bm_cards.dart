import 'package:flutter/material.dart';
import '../location_page/explore_page.dart';
import './bm_handler.dart';

/*
 * BMCard is the template for each bookmarked location, which includes: 
 * a location image, name, and a short description.
 */

class BMCard extends StatelessWidget {
  final Map<String, Object> locDetails;
  final BookmarkHandler bmHandler;
  final Function rmBM;
  BMCard(this.locDetails, this.bmHandler, this.rmBM);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Image.asset("assets/images/cropped/${locDetails["croppedImages"]}"),
              title: Text(locDetails["name"]),
              subtitle: Text(locDetails["description"]),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Learn'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute( builder: (context) => ExplorePage(locDetails)),
                    );
                  },
                ),
                FlatButton(
                  child: const Text('Remove'),
                  onPressed: () {rmBM(locDetails);},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}