// To parse this JSON data, do
//
//     final progressModel = progressModelFromJson(jsonString);

import 'dart:convert';

ProgressModel progressModelFromJson(String str) => ProgressModel.fromJson(json.decode(str));

String progressModelToJson(ProgressModel data) => json.encode(data.toJson());

class ProgressModel {
  final String? id;
  final String? status;
  final DateTime? createdAt;
  final Provider? provider;
  final String? processStatus;
  final String? destAddress;
  final String? totalDistance;
  final String? address;

  ProgressModel({
    this.id,
    this.status,
    this.createdAt,
    this.provider,
    this.processStatus,
    this.destAddress,
    this.totalDistance,
    this.address,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
    id: json["_id"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
    processStatus: json["processStatus"],
    destAddress: json["destAddress"],
    totalDistance: json["totalDistance"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "provider": provider?.toJson(),
    "processStatus": processStatus,
    "destAddress": destAddress,
    "totalDistance": totalDistance,
    "address": address,
  };
}

class Provider {
  final Location? location;
  final String? id;
  final String? name;
  final String? profileImage;
  final String? role;
  final String? address;
  final int? feedbackCount;
  final int? avgRating;
  final double? distance;

  Provider({
    this.location,
    this.id,
    this.name,
    this.profileImage,
    this.role,
    this.address,
    this.feedbackCount,
    this.avgRating,
    this.distance,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    role: json["role"],
    address: json["address"],
    feedbackCount: json["feedbackCount"],
    avgRating: json["avgRating"],
    distance: json["distance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "role": role,
    "address": address,
    "feedbackCount": feedbackCount,
    "avgRating": avgRating,
    "distance": distance,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}
