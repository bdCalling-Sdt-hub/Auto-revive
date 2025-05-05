class GetProfileModel {
  final String? id;
  final String? userId;
  final int? v;
  final List<String>? certifications;
  final List<dynamic>? employmentHistories;
  final List<Experience>? experiences;
  final bool? haveCdl;
  final bool? haveLicense;
  final bool? haveOwnTools;
  final String? platform;
  final List<Reference>? references;
  final List<dynamic>? tools;
  final List<dynamic>? toolsCustom;
  final String? whyOnSite;
  final String? certificate;
  final String? resume;
  final String? name;
  final String? email;
  final Location? location;
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
  final String? address;
  final String? phone;

  GetProfileModel({
    this.id,
    this.userId,
    this.v,
    this.certifications,
    this.employmentHistories,
    this.experiences,
    this.haveCdl,
    this.haveLicense,
    this.haveOwnTools,
    this.platform,
    this.references,
    this.tools,
    this.toolsCustom,
    this.whyOnSite,
    this.certificate,
    this.resume,
    this.name,
    this.email,
    this.location,
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
    this.address,
    this.phone,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    id: json["_id"],
    userId: json["userId"],
    v: json["__v"],
    certifications: json["certifications"] == null ? [] : List<String>.from(json["certifications"]!.map((x) => x)),
    employmentHistories: json["employmentHistories"] == null ? [] : List<dynamic>.from(json["employmentHistories"]!.map((x) => x)),
    experiences: json["experiences"] == null ? [] : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
    haveCdl: json["haveCdl"],
    haveLicense: json["haveLicense"],
    haveOwnTools: json["haveOwnTools"],
    platform: json["platform"],
    references: json["references"] == null ? [] : List<Reference>.from(json["references"]!.map((x) => Reference.fromJson(x))),
    tools: json["tools"] == null ? [] : List<dynamic>.from(json["tools"]!.map((x) => x)),
    toolsCustom: json["toolsCustom"] == null ? [] : List<dynamic>.from(json["toolsCustom"]!.map((x) => x)),
    whyOnSite: json["whyOnSite"],
    certificate: json["certificate"],
    resume: json["resume"],
    name: json["name"],
    email: json["email"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
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
    address: json["address"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "__v": v,
    "certifications": certifications == null ? [] : List<dynamic>.from(certifications!.map((x) => x)),
    "employmentHistories": employmentHistories == null ? [] : List<dynamic>.from(employmentHistories!.map((x) => x)),
    "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
    "haveCdl": haveCdl,
    "haveLicense": haveLicense,
    "haveOwnTools": haveOwnTools,
    "platform": platform,
    "references": references == null ? [] : List<dynamic>.from(references!.map((x) => x.toJson())),
    "tools": tools == null ? [] : List<dynamic>.from(tools!.map((x) => x)),
    "toolsCustom": toolsCustom == null ? [] : List<dynamic>.from(toolsCustom!.map((x) => x)),
    "whyOnSite": whyOnSite,
    "certificate": certificate,
    "resume": resume,
    "name": name,
    "email": email,
    "location": location?.toJson(),
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
    "address": address,
    "phone": phone,
  };
}

class Experience {
  final ExperienceId? experienceId;
  final String? platform;
  final int? time;
  final String? id;

  Experience({
    this.experienceId,
    this.platform,
    this.time,
    this.id,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    experienceId: json["experienceId"] == null ? null : ExperienceId.fromJson(json["experienceId"]),
    platform: json["platform"],
    time: json["time"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "experienceId": experienceId?.toJson(),
    "platform": platform,
    "time": time,
    "_id": id,
  };
}

class ExperienceId {
  final String? id;
  final String? adminId;
  final String? name;
  final int? v;

  ExperienceId({
    this.id,
    this.adminId,
    this.name,
    this.v,
  });

  factory ExperienceId.fromJson(Map<String, dynamic> json) => ExperienceId(
    id: json["_id"],
    adminId: json["adminId"],
    name: json["name"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "adminId": adminId,
    "name": name,
    "__v": v,
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

class Reference {
  final String? name;
  final String? phone;
  final String? relation;

  Reference({
    this.name,
    this.phone,
    this.relation,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
    name: json["name"],
    phone: json["phone"],
    relation: json["relation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "relation": relation,
  };
}
