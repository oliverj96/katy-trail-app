import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushHandler {
  final List<Map<String, Object>> dataPointsCol;
  double _longitude = 0;
  double _latitude = 0;
  bool isUserNearLocation = false;
  Map<String, Object> _locationData;
  PushHandler(this.dataPointsCol);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  

  FlutterLocalNotificationsPlugin get localNotificationPlugin {
    return flutterLocalNotificationsPlugin;
  }

  Map<String, Object> get locationData {
    return _locationData;
  }

  // Get the user's longitude and latitude positions.
  void getPosition() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _longitude = double.parse(position.longitude.toString());
      _latitude = double.parse(position.latitude.toString());
    } catch (e) { 
      // Ignore errors.
    }
  }

  Future showNotification(Map<String, Object> locDetails) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, locDetails['name'], 'Learn about this area!', platform);
  }

  /*
    // If user is close enough to a location but has not previously been close enough to that location
    if (!inside( [ latitude, longitude ], polygon) && !isUserNearLocation) {
      isUserNearLocation = false; 
    }
    // If user is close enough to a location and continues to be close enough to that location
    else if (inside([ latitude, longitude ], polygon) && !isUserNearLocation) {
      isUserNearLocation = true;         
    }
    // If a user is not close enough to a location but was previously close enough to a location
    else if(inside([ latitude, longitude ], polygon) && isUserNearLocation) {
      isUserNearLocation = true; 
    } 
*/


  // return true or false based on if user's location intersects with specified coordinates polygon
  bool inside(point, vs) {
    // Ray-casting algorithm based on
    // http://www.ecse.rpi.edu/Homepages/wrf/Research/Short_Notes/pnpoly.html
    var x = point[0], y = point[1];

    var inside = false;
    for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
      var xi = vs[i][0], yi = vs[i][1];
      var xj = vs[j][0], yj = vs[j][1];

      var intersect =
          ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) inside = !inside;
    }

    return inside;
  }


  // Print true or false if user is within specified coordinates square
  // print(inside([ 38.766974, -90.489245 ], polygon));

/*
  // Use to check if a user's current location is near a location's vicinity
  checkDistance() {
    var distance = 0.01;
    var latDistance = 0.0;
    var longDistance = 0.0;

    for (var location in dataPointsCol) {
      // Go through all the points in the database coming in ["lat"] ["long"]

      latDistance = (_latitude - location["lat"]).abs();
      print(latDistance);
      longDistance = (_longitude - location["long"]).abs();
      print(longDistance);

      // If user is close enough to a location but has not previously been close enough to that location
      if ((latDistance <= distance) &&
          (longDistance <= distance) ) { //&& !isUserNearLocation
        //isUserNearLocation = false;
        //_locationData = location;
        print("yes");
        //showNotification(location); // Send the push notification
      }
      // If user is close enough to a location and continues to be close enough to that location
      else if ((latDistance <= distance) &&
          (longDistance <= distance) ) { //&& isUserNearLocation
          
        //isUserNearLocation = true;
        //print("no");
      }
    }
  }*/
}