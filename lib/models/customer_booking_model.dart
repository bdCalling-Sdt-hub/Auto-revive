

class CustomerBookingModel {
  final String? id;
  final ProviderId? providerId;
  final String? status;
  final String? platform;
  final List<dynamic>? services;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? transportPrice;
  final num? servicePrice;
  final String? carModel;

  CustomerBookingModel( {
    this.platform,
    this.id,
    this.providerId,
    this.status,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.transportPrice,
    this.servicePrice,
    this.carModel
  });

  factory CustomerBookingModel.fromJson(Map<String, dynamic> json) => CustomerBookingModel(
    id: json["_id"],
    platform : json["platform"],
    providerId: json["providerId"] == null ? null : ProviderId.fromJson(json["providerId"]),
    status: json["status"],
    services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    transportPrice: json["transportPrice"],
    servicePrice: json["servicePrice"],
    carModel: json["carModel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerId": providerId?.toJson(),
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "transportPrice": transportPrice,
    "servicePrice": servicePrice,
    "carModel": carModel,
    "platform": platform,
  };
}

class ProviderId {
  final List<num>? location;
  final String? id;
  final String? name;
  final String? profileImage;
  final String? role;
  final String? address;
  final int? feedbackCount;
  final num? avgRating;
  final num? distance;
  final List<String>? certifications;

  ProviderId({
    this.location,
    this.id,
    this.name,
    this.profileImage,
    this.role,
    this.address,
    this.feedbackCount,
    this.avgRating,
    this.distance,
    this.certifications,
  });

  factory ProviderId.fromJson(Map<String, dynamic> json) => ProviderId(
    location: json["location"] == null ? [] : List.from(json["location"]!.map((x) => x)),
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    role: json["role"],
    address: json["address"],
    feedbackCount: json["feedbackCount"],
    avgRating: json["avgRating"] is num ? json["avgRating"] : null,
    distance: json["distance"],
    certifications: json["certifications"] == null ? [] : List<String>.from(json["certifications"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "role": role,
    "address": address,
    "feedbackCount": feedbackCount,
    "avgRating": avgRating,
    "distance": distance,
    "certifications": certifications == null ? [] : List<dynamic>.from(certifications!.map((x) => x)),
  };
}
