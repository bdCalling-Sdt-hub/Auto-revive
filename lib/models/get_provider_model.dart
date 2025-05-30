class ProviderModel {
  final String? id;
  final ErId? providerId;
  final ErId? customerId;
  final double? servicePrice;
  final String? status;
  final List<dynamic>? services;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? location;
  final String? destination;
  final double? totalDistance;

  ProviderModel({
    this.id,
    this.providerId,
    this.customerId,
    this.servicePrice,
    this.status,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.location,
    this.destination,
    this.totalDistance,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
    id: json["_id"],
    providerId: json["providerId"] == null ? null : ErId.fromJson(json["providerId"]),
    customerId: json["customerId"] == null ? null : ErId.fromJson(json["customerId"]),
    servicePrice: json["servicePrice"] == null ? null : double.tryParse(json["servicePrice"].toString()),
    status: json["status"],
    services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    location: json["location"],
    destination: json["destination"],
    totalDistance: json["totalDistance"] == null ? null : double.tryParse(json["totalDistance"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerId": providerId?.toJson(),
    "customerId": customerId?.toJson(),
    "servicePrice": servicePrice,
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "location": location,
    "destination": destination,
    "totalDistance": totalDistance,
  };
}

class ErId {
  final String? id;
  final String? name;
  final String? profileImage;
  final String? address;
  final String? erIdId;

  ErId({
    this.id,
    this.name,
    this.profileImage,
    this.address,
    this.erIdId,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    address: json["address"],
    erIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "address": address,
    "id": erIdId,
  };
}
