/* This is the database. 
  New locations will be added from here and old locations will also be managed here.
  If you would like to add a new location please copy the following:
  {
    "name": "LOCATION NAME ",
    "description": "Short Description",
    "LongDes":
        "Long description " +
        "Description" +
        " " +
        " ",
    "citations":  "() ",        
    "lat": LATITUDE VALUE,
    "long": LONGITUDE VALUE,
    "images": "Image.png", 
    "croppedImages": "Square-cropped-image.jpg"
  },
*/

class Locations {
  var _data = [
    {
      "name": "Missouri’s First Capital",
      "description": "Missouri's first capital building",
      "LongDes": "The first Missouri State Capital Historic Site holds years of history. " +
          "It was Missouri’s first capital building between statehood in 1821 and the capital moving to Jefferson City in 1826. " +
          "The building was restored in the 1960s. It features 11 rooms to take you back in history. " +
          "Tours are available at the State Capital Historic Site office next door. " +
          "Here’s the site before the state restored it and then how it looks today. ",
      "citations":  "(Images: St. Charles County Historical Society, Missouri State Parks) ",
      "lat": 38.784926,
      "long": -90.478854,
      "images": "FCapital1.png:FCapital2.png",
      "croppedImages": "FCapital_cropped.jpg"
    },
    {
      "name": "Pilot Grove",
      "description": "Small horse-powered mill settlement",
      "LongDes": "Little is known about the origin of Pilot Grove, " +
          "except that the small horse-powered mill settlement was created in 1820 on a tributary of the Petite Saline Creek. " +
          "Half a mile northeast of Pilot Grove, a Katy Railroad train carrying WWII supplies of crude oil and artillery shells " +
          "derailed and exploded, sending shrapnel a half mile down to the Pilot Grove depot. ",
      "citations":  "(Image: The Katy Trail) ",
      "lat": 38.60881,
      "long": -90.794006,
      "images": "PilotGrove.png",
      "croppedImages": "Pilotgrove_cropped.jpg"
    },
    {
      "name": "Augusta Cemetery",
      "description": "Monument and burial site of Daniel Boone",
      "LongDes": "Just a mile’s ride north of here is the Augusta Cemetery, created in 1859. " +
          "The earliest residents of Augusta were German immigrants, attracted here by its landscape— and " +
          "the writings of Gottfried Duden, promoting it a “Rhineland.” When you arrive at the cemetery, " +
          "the oldest sections are to the south (your right as you face the gate). " +
          "Notice the inscriptions in German that date to even the early twentieth century, like this one of John Fuhr. ",
      "citations":  "(Image: Augusta Trail) ",
      "lat": 38.580103,
      "long": -90.884011,
      "images": "Augusta.png",
      "croppedImages": "Augusta_cropped.jpg"
    },
    {
      "name": "MKT RAILROAD ",
      "description": "The Missouri Kansas & Texas Railroad",
      "LongDes":
          "The Missouri Kansas and Texas Railroad— the “Katy” —was built in 1865;" +
          " Union Pacific acquired it in 1988. The Katy Railroad had more than" +
          " 3,377 miles of track  servicing a booming coal industry. " +
          "Engines like this one connected the Midwest to Texas.",
      "citations":  "(Image: St. Charles Frontier Park) ",
      "lat": 38.777167,
      "long": -90.482046,
      "images": "MKT.png",
      "croppedImages": "MKT_cropped.jpg"
    },
    /*PASTE THE FORMAT HERE TO ADD THE NEW LOCATION*/
  ];
  List<Map<String, Object>> get data {
    return _data;
  }
}
