

class FindMechanicCustomerModel {
  final Location? location;
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
  final String? address;
  final String? findMechanicModelId;

  FindMechanicCustomerModel({
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
    this.address,
    this.findMechanicModelId,
  });

  factory FindMechanicCustomerModel.fromJson(Map<String, dynamic> json) => FindMechanicCustomerModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
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
    address: json["address"],
    findMechanicModelId: json["id"],
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
    "address": address,
    "id": findMechanicModelId,
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
