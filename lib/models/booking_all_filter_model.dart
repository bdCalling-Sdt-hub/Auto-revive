class BookingAllFiltersModel {
  final String? id;
  final JobId? jobId;
  final CustomerId? customerId;
  final String? status;
  final List<dynamic>? services;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? carModel;

  BookingAllFiltersModel({
    this.id,
    this.jobId,
    this.customerId,
    this.status,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.carModel,
  });

  factory BookingAllFiltersModel.fromJson(Map<String, dynamic> json) => BookingAllFiltersModel(
    id: json["_id"],
    jobId: json["jobId"] == null ? null : JobId.fromJson(json["jobId"]),
    customerId: json["customerId"] == null ? null : CustomerId.fromJson(json["customerId"]),
    status: json["status"],
    services: json["services"] == null ? [] : List<dynamic>.from(json["services"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    carModel: json["carModel"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "jobId": jobId?.toJson(),
    "customerId": customerId?.toJson(),
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "carModel": carModel,
  };
}

class CustomerId {
  final List<num>? location;
  final String? id;
  final String? name;
  final String? profileImage;
  final String? address;
  final String? customerIdId;

  CustomerId({
    this.location,
    this.id,
    this.name,
    this.profileImage,
    this.address,
    this.customerIdId,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    location: json["location"] == null ? [] : List.from(json["location"]!.map((x) => x)),
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    address: json["address"],
    customerIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "address": address,
    "id": customerIdId,
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
