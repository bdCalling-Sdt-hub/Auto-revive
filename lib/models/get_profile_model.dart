class GetProfileModel {
  final String? id;
  final String? userId;
  final int? v;
  final List<String>? certifications;
  final List<EmploymentHistory>? employmentHistories;
  final List<Experience>? experiences;
  final bool? haveCdl;
  final bool? haveLicense;
  final bool? haveOwnTools;
  final String? platform;
  final List<Reference>? references;
  final List<Tool>? tools;
  final List<String>? toolsCustom;
  final String? whyOnSite;
  final String? certificate;
  final String? resume;
  final ToolsGroup? toolsGroup;
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
    this.toolsGroup,
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
    employmentHistories: json["employmentHistories"] == null ? [] : List<EmploymentHistory>.from(json["employmentHistories"]!.map((x) => EmploymentHistory.fromJson(x))),
    experiences: json["experiences"] == null ? [] : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
    haveCdl: json["haveCdl"],
    haveLicense: json["haveLicense"],
    haveOwnTools: json["haveOwnTools"],
    platform: json["platform"],
    references: json["references"] == null ? [] : List<Reference>.from(json["references"]!.map((x) => Reference.fromJson(x))),
    tools: json["tools"] == null ? [] : List<Tool>.from(json["tools"]!.map((x) => Tool.fromJson(x))),
    toolsCustom: json["toolsCustom"] == null ? [] : List<String>.from(json["toolsCustom"]!.map((x) => x)),
    whyOnSite: json["whyOnSite"],
    certificate: json["certificate"],
    resume: json["resume"],
    toolsGroup: json["toolsGroup"] == null ? null : ToolsGroup.fromJson(json["toolsGroup"]),
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
    "employmentHistories": employmentHistories == null ? [] : List<dynamic>.from(employmentHistories!.map((x) => x.toJson())),
    "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
    "haveCdl": haveCdl,
    "haveLicense": haveLicense,
    "haveOwnTools": haveOwnTools,
    "platform": platform,
    "references": references == null ? [] : List<dynamic>.from(references!.map((x) => x.toJson())),
    "tools": tools == null ? [] : List<dynamic>.from(tools!.map((x) => x.toJson())),
    "toolsCustom": toolsCustom == null ? [] : List<dynamic>.from(toolsCustom!.map((x) => x)),
    "whyOnSite": whyOnSite,
    "certificate": certificate,
    "resume": resume,
    "toolsGroup": toolsGroup?.toJson(),
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

class EmploymentHistory {
  final String? companyName;
  final String? jobName;
  final String? supervisorsName;
  final String? supervisorsContact;
  final DateTime? durationFrom;
  final DateTime? durationTo;
  final String? platform;
  final String? reason;
  final String? id;

  EmploymentHistory({
    this.companyName,
    this.jobName,
    this.supervisorsName,
    this.supervisorsContact,
    this.durationFrom,
    this.durationTo,
    this.platform,
    this.reason,
    this.id,
  });

  factory EmploymentHistory.fromJson(Map<String, dynamic> json) => EmploymentHistory(
    companyName: json["companyName"],
    jobName: json["jobName"],
    supervisorsName: json["supervisorsName"],
    supervisorsContact: json["supervisorsContact"],
    durationFrom: json["durationFrom"] == null ? null : DateTime.parse(json["durationFrom"]),
    durationTo: json["durationTo"] == null ? null : DateTime.parse(json["durationTo"]),
    platform: json["platform"],
    reason: json["reason"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "jobName": jobName,
    "supervisorsName": supervisorsName,
    "supervisorsContact": supervisorsContact,
    "durationFrom": durationFrom?.toIso8601String(),
    "durationTo": durationTo?.toIso8601String(),
    "platform": platform,
    "reason": reason,
    "_id": id,
  };
}

class Experience {
  final Tool? experienceId;
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
    experienceId: json["experienceId"] == null ? null : Tool.fromJson(json["experienceId"]),
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

class Tool {
  final String? id;
  final AdminId? adminId;
  final String? name;
  final int? v;
  final Group? group;

  Tool({
    this.id,
    this.adminId,
    this.name,
    this.v,
    this.group,
  });

  factory Tool.fromJson(Map<String, dynamic> json) => Tool(
    id: json["_id"],
    adminId: adminIdValues.map[json["adminId"]],
    name: json["name"],
    v: json["__v"],
    group: groupValues.map[json["group"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "adminId": adminIdValues.reverse[adminId],
    "name": name,
    "__v": v,
    "group": groupValues.reverse[group],
  };
}

enum AdminId {
  THE_680_F1_B85_F659_B628_C193_C22_A
}

final adminIdValues = EnumValues({
  "680f1b85f659b628c193c22a": AdminId.THE_680_F1_B85_F659_B628_C193_C22_A
});

enum Group {
  BASIC_HAND,
  GROUP_2,
  GROUP_3
}

final groupValues = EnumValues({
  "Basic hand": Group.BASIC_HAND,
  "Group 2": Group.GROUP_2,
  "Group 3": Group.GROUP_3
});




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

class ToolsGroup {
  final List<Tool>? basicHand;
  final List<Tool>? group2;
  final List<Tool>? group3;

  ToolsGroup({
    this.basicHand,
    this.group2,
    this.group3,
  });

  factory ToolsGroup.fromJson(Map<String, dynamic> json) => ToolsGroup(
    basicHand: json["Basic hand"] == null ? [] : List<Tool>.from(json["Basic hand"]!.map((x) => Tool.fromJson(x))),
    group2: json["Group 2"] == null ? [] : List<Tool>.from(json["Group 2"]!.map((x) => Tool.fromJson(x))),
    group3: json["Group 3"] == null ? [] : List<Tool>.from(json["Group 3"]!.map((x) => Tool.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Basic hand": basicHand == null ? [] : List<dynamic>.from(basicHand!.map((x) => x.toJson())),
    "Group 2": group2 == null ? [] : List<dynamic>.from(group2!.map((x) => x.toJson())),
    "Group 3": group3 == null ? [] : List<dynamic>.from(group3!.map((x) => x.toJson())),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
