import 'package:autorevive/core/app_constants/app_constants.dart';
import 'package:autorevive/helpers/prefs_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/socket_services.dart';

class LiveLocationChangeController extends GetxController {
  final loc.Location location = loc.Location();
  LatLng center = const LatLng(0, 0);
  GoogleMapController? mapController;

  ///=====================  Live Location Changing ======================>>>
  bool isMapReady = false;

  void listenToLocationChanges() async{

    var userId = await PrefsHelper.getString(AppConstants.userId);

    location.onLocationChanged.listen((loc.LocationData newLocation) {
      double? lat = newLocation.latitude;
      double? lng = newLocation.longitude;


      if (lat != null && lng != null) {
        center = LatLng(lat, lng);
        debugPrint(
            "📍 =============================>>>  Location changed: $lat, $lng");

        SocketServices sockService = SocketServices();


        sockService.emit("location-share", {
          {
            "userId": "$userId",
            "lng": lng.toDouble(),
            "lat": lat.toDouble()
          }
        });

        update();
      }
    });
  }

  @override
  void onInit() {
    listenToLocationChanges();
    super.onInit();
  }
}
