

import 'package:autorevive/models/find_mechanic_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class CustomerMapController extends GetxController {
  GoogleMapController? mapController;
  CameraPosition? initialCameraPosition;
  LatLng center = const LatLng(0, 0);

  double miles = 5.0;
  Set<Circle> circles = {};
  bool isLoading = true;
  final loc.Location location = loc.Location();



  void updateCircle(double miles) {
    final radiusInMeters = miles * 1609.34;

    circles = {
      Circle(
        circleId: const CircleId('radius'),
        center: center,
        radius: radiusInMeters,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    };

    update(); // Notifies GetBuilder
  }

  void updateCenter(LatLng newCenter) {
    center = newCenter;
    update();
  }

  Future<void> setInitialLocation() async {
    try {
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) throw Exception("Location service disabled");
      }

      PermissionStatus permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission != PermissionStatus.granted) {
          throw Exception("Location permission not granted");
        }
      }

      final locationData = await location.getLocation();
      center = LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      initialCameraPosition = CameraPosition(target: center, zoom: 14.0);
    } catch (e) {
      debugPrint('Location error: $e');

      // Fallback to Dhaka
      center = const LatLng(23.8103, 90.4125);
      initialCameraPosition = CameraPosition(target: center, zoom: 12.0);
      Get.snackbar("Location Error", "Using fallback location in Dhaka.");
    }

    updateCircle(miles);
    isLoading = false;
    update();
  }




  /// ================================> Get All Mechanic ==============================>

  RxBool mechanicLoading = false.obs;
  RxList<FindMechanicCustomerModel> mechanic = <FindMechanicCustomerModel>[].obs;
  fetchMechanicWithRadius({String? radius})async{
    mechanicLoading(true);
    var response = await ApiClient.getData(ApiConstants.findMechanicRadius+"/$radius");
    if(response.statusCode == 200){
      mechanic.value = List<FindMechanicCustomerModel>.from(response.body["data"].map((x)=> FindMechanicCustomerModel.fromJson(x)));
      mechanicLoading(false);
    }else{
      mechanicLoading(false);
    }
  }




  @override
  void onInit() {
    super.onInit();
    _listenToLocationChanges();
  }


  ///=====================  Live Location Changing ======================>>>

  void _listenToLocationChanges() {
    location.onLocationChanged.listen((loc.LocationData newLocation) {
      double? lat = newLocation.latitude;
      double? lng = newLocation.longitude;

      if (lat != null && lng != null) {
        center = LatLng(lat, lng);
        debugPrint("📍 =============================>>>  Location changed: $lat, $lng");

        mapController?.animateCamera(
          CameraUpdate.newLatLng(center),
        );

        updateCircle(miles);

        update();
      }
    });
  }



}
