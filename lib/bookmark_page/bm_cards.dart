import 'package:flutter/material.dart';
import '../location_page/ExplorePage.dart';
import './bm_handler.dart';

class BMCard extends StatelessWidget {
  final Map<String, Object> locDetails;
  final BookmarkHandler bmHandler;
  final Function rmBM;
  BMCard(this.locDetails, this.bmHandler, this.rmBM);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: child,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
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