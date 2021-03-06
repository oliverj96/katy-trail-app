import 'package:flutter/material.dart';
import './explore_page.dart';
import '../bookmark_page/bm_handler.dart';

/*
 * LocationListCard is the template for location card design to use in the explore page. 
 * It gives the ability to add and remove bookmarks from the bookmark page. 
 */


class LocationListCard extends StatefulWidget {
  final Map<String, Object> locDetails;
  final BookmarkHandler bmHandler;
  const LocationListCard(this.locDetails, this.bmHandler);

  @override
  _LocationListCardState createState() => _LocationListCardState();
}

class _LocationListCardState extends State<LocationListCard> {

  // Add a location to the bookmark page 
  void addBM(){
    setState(() {
      widget.bmHandler.addBookmark(widget.locDetails);
    });
  }

  // Remove a location from the bookmark page 
  void removeBM(){
    setState(() {
      widget.bmHandler.removeBookmark(widget.locDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    FlatButton bmButton;
    if (widget.bmHandler.isBookmarked(widget.locDetails)) {
      bmButton = FlatButton(
        child: const Text('Remove'),
        onPressed: () {
          // Remove from bookmark
          removeBM();
        },
      );
    }
    else {
      bmButton = FlatButton(
        child: const Text('Bookmark'),
        onPressed: () {
          // Add to bookmark
          addBM();
        },
      );
    }

    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[            
            ListTile(
              leading: Image.asset("assets/images/cropped/${widget.locDetails["croppedImages"]}"),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute( builder: (context) => ExplorePage(widget.locDetails)),
                );
              },
              title: Text(widget.locDetails["name"]),
              subtitle: Text(widget.locDetails["description"]),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Learn'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute( builder: (context) => ExplorePage(widget.locDetails)),
                    );
                  },
                ),
                bmButton,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
