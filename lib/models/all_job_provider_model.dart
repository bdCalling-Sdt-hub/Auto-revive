class AllJobProviderModel {
  final String? id;
  final CustomerId? customerId;
  final CarModelId? carModelId;
  final String? platform;
  final DateTime? createdAt;

  AllJobProviderModel({
    this.id,
    this.customerId,
    this.carModelId,
    this.platform,
    this.createdAt,
  });

  factory AllJobProviderModel.fromJson(Map<String, dynamic> json) => AllJobProviderModel(
    id: json["_id"],
    customerId: json["customerId"] == null ? null : CustomerId.fromJson(json["customerId"]),
    carModelId: json["carModelId"] == null ? null : CarModelId.fromJson(json["carModelId"]),
    platform: json["platform"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId?.toJson(),
    "carModelId": carModelId?.toJson(),
    "platform": platform,
    "createdAt": createdAt?.toIso8601String(),
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

class CustomerId {
  final String? id;
  final String? name;
  final String? profileImage;
  final String? customerIdId;

  CustomerId({
    this.id,
    this.name,
    this.profileImage,
    this.customerIdId,
  });

  factory CustomerId.fromJson(Map<String, dynamic> json) => CustomerId(
    id: json["_id"],
    name: json["name"],
    profileImage: json["profileImage"],
    customerIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "profileImage": profileImage,
    "id": customerIdId,
  };
}
