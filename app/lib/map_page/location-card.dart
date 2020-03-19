import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  final String name;
  final String description;

  LocationCard(this.name, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(fontSize: 28),
              ),
              Text(description),
            ],
          ),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // TODO when locations are implemented, add link here
            },
          )
        ],
      ),
      height: 100,
    );
  }
}
