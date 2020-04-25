import 'package:geolocator/geolocator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushHandler {
  final List<Map<String, Object>> dataPointsCol;
  double _longitude = 0;
  double _latitude = 0;
  bool alreadyNearBy = false;
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
  Future getPosition() async {
    try {
      print("hello1");
      var position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("hello");
      _longitude = double.parse(position.longitude.toString());
      _latitude = double.parse(position.latitude.toString());
    } catch (e) {
      print(e);
      // Ignore errors.
    }
  }

  showNotification(Map<String, Object> locDetails) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(
        0, locDetails['name'], 'Learn about this area!', platform);
  }

  // Use to check if a user's current location is near a location's vicinity
  checkDistance() {
    const distance = 0.1;
    var latDistance = 0.0;
    var longDistance = 0.0;
    for (var location in dataPointsCol) {
      // Go through all the points in the database coming in ["lat"] ["long"]

      latDistance = (_latitude - location["lat"]).abs();
      print(_latitude);
      longDistance = (_longitude - location["long"]).abs();
      print(_longitude);

      var nearBy = (latDistance <= distance) && (longDistance <= distance);
      // If user is close enough to a location but has not previously been close enough to that location
      if (nearBy && !alreadyNearBy) {
        alreadyNearBy = true;
        _locationData = location;
        showNotification(location); // Send the push notification
      }
      // If user is close enough to a location and continues to be close enough to that location
      else if (!nearBy && !alreadyNearBy) {
        alreadyNearBy = false;
      }
    }
  }
}
