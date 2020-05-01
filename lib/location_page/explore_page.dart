import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  final Map<String, Object> locDetails;
  const ExplorePage(this.locDetails);

  @override
  Widget build(BuildContext context) {
    Image firstImage;
    var images = locDetails["images"].toString().split(':');
    if (images[0].length > 0) {
      firstImage = Image.asset(getAssetPath(images[0]));
    } else {
      firstImage = Image.asset(
        "assets/images/noimage.png",
        height: 150,
      );
    }

    // Create basic template for explore page
    List<Widget> template = [
      Center(
        child: Text(
          "${locDetails["description"]}\n",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      firstImage,
      Text(
        "\n${locDetails["LongDes"]}",
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      Text(
        "\n${locDetails["citations"]}",
        style: TextStyle(
          fontSize: 15,
        ),
      )
    ];

    // Append any remaining images to the end of the page
    if (images.length > 1) {
      images.removeAt(0);
      for (var img in images) {
        template.add(Image.asset(getAssetPath(img)));
      }
    }

    // Create the scaffold app page
    return Scaffold(
      // child: child,
      appBar: new AppBar(title: Text(locDetails["name"])),
      body: Container(
        child: ListView(
          children: template,
        ),
        margin: EdgeInsets.all(20),
      ),
    );
  }

  String getAssetPath(String name) {
    return "assets/images/$name";
  }
}
