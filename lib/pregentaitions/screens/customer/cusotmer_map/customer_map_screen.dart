
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerMapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<CustomerMapScreen> {
  GoogleMapController? _controller;

  // Marker position
  LatLng _center = LatLng(37.7749, -122.4194);  // Set your desired location
  Set<Circle> _circles = {};  // For storing circles

  @override
  void initState() {
    super.initState();
  }

  // Function to add a circle on the map
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    // Adding a circle to represent the radius
    setState(() {
      _circles.add(Circle(
        circleId: CircleId('radius'),
        center: _center,  // Center of the circle
        radius: 1000,     // Radius in meters (1000 meters = 1 km)
        fillColor: Colors.blue.withOpacity(0.5),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map with Radius'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 14.0,  // Adjust zoom level as necessary
        ),
        circles: _circles,  // Add the circle to the map
      ),
    );
  }
}