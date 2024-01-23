import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await geolocator.requestPermission();

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
        setState(() {
          currentPosition = position;
        });

        // Access altitude and speed
        double elevation = currentPosition?.altitude ?? 0.0;
        double speed = currentPosition?.speed ?? 0.0;

        print(position.altitudeAccuracy);
        print(position.isMocked);
        print(position.latitude);
        print(position.longitude);

        // Use elevation and speed data as needed
        print('Elevation: $elevation, Speed: $speed');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ski Tracking App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Altitude: ${currentPosition?.altitude ?? 0.0}'),
            Text('Altitude Accuracy: ${currentPosition?.altitudeAccuracy ?? 0.0}'),
            Text('Speed: ${currentPosition?.speed ?? 0.0}'),
            Text('Latitude: ${currentPosition?.latitude ?? 0.0}'),
            Text('Longitude: ${currentPosition?.longitude ?? 0.0}'),
            Text('Heading: ${currentPosition?.heading ?? 0.0}'),
            Text('Timestamp: ${currentPosition?.timestamp.toLocal() ?? 0.0}'),
          ],
        ),
      ),
    );
  }
}
