import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class CurrentLocationController extends GetxController {

  final loc.Location location = loc.Location();
  CameraPosition? initialCameraPosition;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  RxString address = ''.obs;
  GoogleMapController? mapController;
  LatLng center = const LatLng(0, 0);



  Future<void> getCurrentLocation() async {
    isLoading.value = true;

    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    // ১. Location service on আছে কিনা চেক
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        isLoading.value = false;
        return;
      }
    }

    // ২. Permission আছে কিনা চেক
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        isLoading.value = false;
        return;
      }
    }

    // ৩. Location data নিন
    final locData = await location.getLocation();

    latitude.value = locData.latitude ?? 0.0;
    longitude.value = locData.longitude ?? 0.0;


    final locationData = await location.getLocation();
    center = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
    initialCameraPosition = CameraPosition(target: center, zoom: 14.0);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latitude.value,
        longitude.value,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address.value = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        update();
      } else {
        address.value = "Address not found";
      }
    } catch (e) {
      address.value = "Failed to get address";
    }


    isLoading.value = false;
  }



  double calculateDistance(double endLat, double endLng) {
    const double earthRadius = 6371000;

    double dLat = _degreesToRadians(endLat - latitude.toDouble());
    double dLng = _degreesToRadians(endLng - longitude.toDouble());

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(latitude.toDouble())) *
            cos(_degreesToRadians(endLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance / 1000;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }





}
