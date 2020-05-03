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

  // Get the user's longitude and latitude positions
  Future getPosition() async {
    Position position;
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      // Ignore errors.
      return;
    }
    _longitude = double.parse(position.longitude.toString());
    _latitude = double.parse(position.latitude.toString());
  }

  // Use to show push notification of a specified location
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
    const distance = 0.003;
    var latDistance = 0.0;
    var longDistance = 0.0;
    var atAnyLocation = false;
    var nearBy = false;
    for (var location in dataPointsCol) {
      // Go through all the points in the database coming in ["lat"] ["long"]

      latDistance = (_latitude - location["lat"]).abs();
      longDistance = (_longitude - location["long"]).abs();

      nearBy = (latDistance <= distance) && (longDistance <= distance);
      if (nearBy && alreadyNearBy) {
        return;
      }
      // If user is close enough to a location but has not previously been close enough to that location
      print("Nearby: $nearBy alreadyNearby: $alreadyNearBy");
      if (nearBy && !alreadyNearBy) {
        this.alreadyNearBy = true;
        atAnyLocation = true;
        _locationData = location;
        showNotification(location); // Send the push notification
        return;
      }
    }
    if (!atAnyLocation && !nearBy) {
      alreadyNearBy = false;
    }
  }
}
