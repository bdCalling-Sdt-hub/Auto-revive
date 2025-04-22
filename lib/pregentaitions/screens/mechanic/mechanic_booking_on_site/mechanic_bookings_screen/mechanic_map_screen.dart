import 'package:autorevive/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../widgets/mechanic_profile_card.dart';

class MechanicMapScreen extends StatefulWidget {
  @override
  _MechanicMapScreenState createState() => _MechanicMapScreenState();
}

class _MechanicMapScreenState extends State<MechanicMapScreen> {
  final LatLng _center = const LatLng(37.7749, -122.4194); // San Francisco
  Set<Circle> _circles = {};
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {}; // Marker set

  double _distance = 4;

  final LatLng _startLocation = const LatLng(37.7749, -122.4194); // San Francisco
  final LatLng _destinationLocation = const LatLng(37.7849, -122.4294); // Nearby location

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _updateCircle(_distance);
    _setPolylines();
    _setMarkers(); // Set markers when map is created
  }

  void _updateCircle(double miles) {
    final radiusInMeters = miles * 1609.34;
    setState(() {
      _circles = {
        Circle(
          circleId: const CircleId('radius'),
          center: _center,
          radius: radiusInMeters,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      };
    });
  }

  // Function to draw polyline between two locations
  void _setPolylines() {
    setState(() {
      _polylines = {
        Polyline(
          polylineId: const PolylineId('route1'),
          color: AppColors.primaryColor,
          width: 5,
          points: [
            _startLocation,
            _destinationLocation,
          ],
        ),
      };
    });
  }

  // Function to set markers
  void _setMarkers() {
    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('start'),
          position: _startLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Start Location'),
        ),
        Marker(
          markerId: const MarkerId('destination'),
          position: _destinationLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed ),
          infoWindow: InfoWindow(title: 'Destination'),
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            circles: _circles,
            polylines: _polylines,
            markers: _markers, // Show markers on the map
          ),
          Positioned(
            top: 60,
            left: 15,
            right: 15,
            child: Container(
              padding: EdgeInsets.only(left: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [BoxShadow(blurRadius: 10.r, color: Colors.black12)],
              ),
              child: const Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Color(0xff9D9D9D)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MechanicProfileCard(
              image: 'assets/images/mapprofile.png',
              name: 'David Bryan',
              location: 'New York, USA',
              rating: 4.85,
            ),
          ),
          SizedBox(height: 29.h),
        ],
      ),
    );
  }
}
