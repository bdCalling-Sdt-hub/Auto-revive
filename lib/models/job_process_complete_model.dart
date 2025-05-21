class JobProcessCompleteModel {
  final String? id;
  final ErId? providerId;
  final JobId? jobId;
  final ErId? customerId;
  final String? status;
  final List<Service>? services;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? servicePrice;

  JobProcessCompleteModel({
    this.id,
    this.providerId,
    this.jobId,
    this.customerId,
    this.status,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.servicePrice,
  });

  factory JobProcessCompleteModel.fromJson(Map<String, dynamic> json) => JobProcessCompleteModel(
    id: json["_id"],
    providerId: json["providerId"] == null ? null : ErId.fromJson(json["providerId"]),
    jobId: json["jobId"] == null ? null : JobId.fromJson(json["jobId"]),
    customerId: json["customerId"] == null ? null : ErId.fromJson(json["customerId"]),
    status: json["status"],
    services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    servicePrice: json["servicePrice"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "providerId": providerId?.toJson(),
    "jobId": jobId?.toJson(),
    "customerId": customerId?.toJson(),
    "status": status,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "servicePrice": servicePrice,
  };
}

class ErId {
  final Ation? location;
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;
  final String? role;
  final String? status;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final bool? isDeleted;
  final int? failedLoginAttempts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userNo;
  final int? v;
  final int? step;
  final double? wallet;
  final String? sid;
  final String? address;
  final String? erIdId;

  ErId({
    this.location,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImage,
    this.role,
    this.status,
    this.isEmailVerified,
    this.isResetPassword,
    this.isDeleted,
    this.failedLoginAttempts,
    this.createdAt,
    this.updatedAt,
    this.userNo,
    this.v,
    this.step,
    this.wallet,
    this.sid,
    this.address,
    this.erIdId,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
    location: json["location"] == null ? null : Ation.fromJson(json["location"]),
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    profileImage: json["profileImage"],
    role: json["role"],
    status: json["status"],
    isEmailVerified: json["isEmailVerified"],
    isResetPassword: json["isResetPassword"],
    isDeleted: json["isDeleted"],
    failedLoginAttempts: json["failedLoginAttempts"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userNo: json["userNo"],
    v: json["__v"],
    step: json["step"],
    wallet: json["wallet"]?.toDouble(),
    sid: json["sid"],
    address: json["address"],
    erIdId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "profileImage": profileImage,
    "role": role,
    "status": status,
    "isEmailVerified": isEmailVerified,
    "isResetPassword": isResetPassword,
    "isDeleted": isDeleted,
    "failedLoginAttempts": failedLoginAttempts,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userNo": userNo,
    "__v": v,
    "step": step,
    "wallet": wallet,
    "sid": sid,
    "address": address,
    "id": erIdId,
  };
}

class Ation {
  final String? type;
  final List<num>? coordinates;

  Ation({
    this.type,
    this.coordinates,
  });

  factory Ation.fromJson(Map<String, dynamic> json) => Ation(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class JobId {
  final Ation? location;
  final Ation? destination;
  final String? id;
  final String? customerId;
  final String? carModelId;
  final String? platform;
  final List<String>? targets;
  final bool? isDeleted;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  JobId({
    this.location,
    this.destination,
    this.id,
    this.customerId,
    this.carModelId,
    this.platform,
    this.targets,
    this.isDeleted,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory JobId.fromJson(Map<String, dynamic> json) => JobId(
    location: json["location"] == null ? null : Ation.fromJson(json["location"]),
    destination: json["destination"] == null ? null : Ation.fromJson(json["destination"]),
    id: json["_id"],
    customerId: json["customerId"],
    carModelId: json["carModelId"],
    platform: json["platform"],
    targets: json["targets"] == null ? [] : List<String>.from(json["targets"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "destination": destination?.toJson(),
    "_id": id,
    "customerId": customerId,
    "carModelId": carModelId,
    "platform": platform,
    "targets": targets == null ? [] : List<dynamic>.from(targets!.map((x) => x)),
    "isDeleted": isDeleted,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Service {
  final int? amount;
  final String? service;

  Service({
    this.amount,
    this.service,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    amount: json["amount"],
    service: json["service"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "service": service,
  };
}
