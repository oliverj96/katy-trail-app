import 'package:flutter/material.dart';
import '../location_page/explore_page.dart';
import '../bookmark_page/bm_handler.dart';

class LocationCard extends StatefulWidget {
  final Map<String, Object> locDetails;
  final List<Map<String, Object>> data;
  final BookmarkHandler bmHandler;
  LocationCard(this.locDetails, this.data, this.bmHandler);

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  Function bmAction;

  @override
  Widget build(BuildContext context) {
    String bmText;
    if (widget.bmHandler.isBookmarked(widget.locDetails)) {
      setState(() {
        bmText = "Remove";
        bmAction = () {
          widget.bmHandler.removeBookmark(widget.locDetails);
        };
      });
    } else {
      setState(() {
        bmText = "Bookmark";
        bmAction = () {
          widget.bmHandler.addBookmark(widget.locDetails);
        };
      });
    }
    return Container(
      height: 180,
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ExplorePage(widget.locDetails)),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/cropped/${widget.locDetails["croppedImages"]}',
                  height: 50,
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    widget.locDetails["name"],
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    widget.locDetails["description"],
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExplorePage(widget.locDetails)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 40.0),
                      child: Text(
                        "Learn",
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bmAction();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        bmText,
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
