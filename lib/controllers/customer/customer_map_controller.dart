

import 'dart:async';
import 'dart:ui' as ui;

import 'package:autorevive/models/find_mechanic_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart' as getx;

import '../../models/marker_model.dart';
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
  Set<Marker> markers = {};
  RxInt dotCount = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    _startDotTimer();
  }


  void _startDotTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      dotCount.value = (dotCount.value + 1) % 4;
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

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

    update();
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
  fetchMechanicWithRadius({String? radius, String? target})async{
    mechanicLoading(true);
    var response = await ApiClient.getData(target?.toLowerCase() == "tow truck" ? "/user/radius/tow_truck/$radius" : ApiConstants.findMechanicRadius+"/$radius");
    if(response.statusCode == 200){
      mechanic.value = List<FindMechanicCustomerModel>.from(response.body["data"].map((x)=> FindMechanicCustomerModel.fromJson(x)));
      var tempMechanic = List<MarkerModels>.from(response.body["data"].map((x)=> MarkerModels.fromJson(x)));


      markers.clear();


      for (var x in tempMechanic) {

        final coordinates = x.coordinates;

        if (coordinates.length >= 2) {
          final lat = coordinates[1];
          final lng = coordinates[0];


          BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

          if (x.profileImage.isNotEmpty) {
              icon = await getBytesFromUrl("${ApiConstants.imageBaseUrl}/${x.profileImage}", size: 100);
          }

          

          print("🧭 Adding marker at: $lat, $lng");

          markers.add(
            Marker(
              markerId: MarkerId(x.id.toString()),
              position: LatLng(lat.toDouble(), lng.toDouble()),
              infoWindow: InfoWindow(title: x.name ?? "Mechanic"),
              icon: icon,


            ),
          );

        } else {
          print("⚠️ Skipping mechanic ${x.id} due to missing coordinates");
        }
      }



      update();

      mechanicLoading(false);
    }else{
      mechanicLoading(false);
    }
  }





  Future<BitmapDescriptor> getBytesFromUrl(String url, {int size = 100}) async {
    var response = await http.get(Uri.parse(url));
     var imageData = response.bodyBytes;

    final codec = await ui.instantiateImageCodec(
      imageData,
      targetWidth: size,
      targetHeight: size
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}


