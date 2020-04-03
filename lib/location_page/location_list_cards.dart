import 'package:flutter/material.dart';

class LocationListCard extends StatelessWidget {
  final Map<String, Object> locDetails;
  const LocationListCard(this.locDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  onPressed: () {/* ... */},
                ),
                FlatButton(
                  child: const Text('Bookmark'),
                  onPressed: () {/* ... */},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
