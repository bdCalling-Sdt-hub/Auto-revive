class BookingAllFiltersModel {
  final String? id;
  final ErId? providerId;
  final JobId? jobId;
  final ErId? customerId;
  final String? status;
  final List<dynamic>? services;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  BookingAllFiltersModel({
    this.id,
    this.providerId,
    this.jobId,
    this.customerId,
    this.status,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BookingAllFiltersModel.fromJson(Map<String, dynamic> json) => BookingAllFiltersModel(
    id: json["_id"],
    providerId: json["providerId"] == null ? null : ErId.fromJson(json["providerId"]),
    jobId: json["jobId"] == null ? null : JobId.fromJson(json["jobId"]),
    customerId: json["customerId"] == null ? null : ErId.fromJson(json["customerId"]),
    status: json["status"],
    services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerId": providerId?.toJson(),
    "jobId": jobId?.toJson(),
    "customerId": customerId?.toJson(),
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ErId {
  final Location? location;
  final String? id;
  final String? name;
  final String? profileImage;
  final String? address;
  final String? erIdId;
  final String? role;

  ErId({
    this.location,
    this.id,
    this.name,
    this.profileImage,
    this.address,
    this.erIdId,
    this.role,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    address: json["address"],
    erIdId: json["id"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "address": address,
    "id": erIdId,
    "role": role,
  };
}

class Location {
  final String? type;
  final List<int>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<int>.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class JobId {
  final String? id;
  final CarModelId? carModelId;

  JobId({
    this.id,
    this.carModelId,
  });

  factory JobId.fromJson(Map<String, dynamic> json) => JobId(
    id: json["_id"],
    carModelId: json["carModelId"] == null ? null : CarModelId.fromJson(json["carModelId"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "carModelId": carModelId?.toJson(),
  };
}

class CarModelId {
  final String? id;
  final String? name;

  CarModelId({
    this.id,
    this.name,
  });

  factory CarModelId.fromJson(Map<String, dynamic> json) => CarModelId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
