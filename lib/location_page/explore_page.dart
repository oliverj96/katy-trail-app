import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final Map<String, Object> locDetails;
  const ExplorePage(this.locDetails);

  @override
  Widget build(BuildContext context) {
    Image firstImage;
    List<Image> restImages;
    var images = locDetails["images"].toString().split(':');
    // print(locDetails["images"].toString().split(':'));
    if (images.length > 0) {
      firstImage = Image.asset(images[0]);
    }
    print(images[0]);
    return Scaffold(
      // child: child,
      appBar: new AppBar(title: Text(locDetails["name"])),
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: Text(
                "${locDetails["description"]}\n",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // firstImage,
            Text(
              locDetails["LongDes"],
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
        margin: EdgeInsets.all(20),
      ),
    );
  }
}
