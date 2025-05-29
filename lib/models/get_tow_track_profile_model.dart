class TowTrackProfileModel {
  final String? id;
  final String? userId;
  final int? v;
  final DateTime? createdAt;
  final String? llc;
  final int? ppm;
  final List<String>? services;
  final DateTime? updatedAt;
  final List<Vehicle>? vehicles;
  final String? companyAddress;
  final String? companyEmail;
  final String? companyName;
  final String? companyOwner;
  final String? companyPhone;
  final String? einNo;
  final int? totalTows;
  final String? website;
  final int? yearsInBusiness;
  final String? mcFile;
  final String? mcNo;
  final String? policyFile;
  final int? policyLimit;
  final String? policyNo;
  final String? usDotFile;
  final String? usDotNo;
  final bool? emergency247;
  final String? eta;
  final String? primaryCity;
  final String? primaryCountry;
  final String? regionsCovered;
  final DateTime? authDate;
  final String? authName;
  final dynamic authSignature;
  final String? authTitle;
  final String? name;
  final String? email;
  final Location? location;
  final dynamic profileImage;
  final String? role;
  final String? status;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final bool? isDeleted;
  final int? failedLoginAttempts;
  final int? step;
  final int? userNo;
  final String? address;
  final String? phone;

  TowTrackProfileModel({
    this.id,
    this.userId,
    this.v,
    this.createdAt,
    this.llc,
    this.ppm,
    this.services,
    this.updatedAt,
    this.vehicles,
    this.companyAddress,
    this.companyEmail,
    this.companyName,
    this.companyOwner,
    this.companyPhone,
    this.einNo,
    this.totalTows,
    this.website,
    this.yearsInBusiness,
    this.mcFile,
    this.mcNo,
    this.policyFile,
    this.policyLimit,
    this.policyNo,
    this.usDotFile,
    this.usDotNo,
    this.emergency247,
    this.eta,
    this.primaryCity,
    this.primaryCountry,
    this.regionsCovered,
    this.authDate,
    this.authName,
    this.authSignature,
    this.authTitle,
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
    this.step,
    this.userNo,
    this.address,
    this.phone,
  });

  factory TowTrackProfileModel.fromJson(Map<String, dynamic> json) => TowTrackProfileModel(
    id: json["_id"],
    userId: json["userId"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    llc: json["llc"],
    ppm: json["ppm"],
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    vehicles: json["vehicles"] == null ? [] : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
    companyAddress: json["companyAddress"],
    companyEmail: json["companyEmail"],
    companyName: json["companyName"],
    companyOwner: json["companyOwner"],
    companyPhone: json["companyPhone"],
    einNo: json["einNo"],
    totalTows: json["totalTows"],
    website: json["website"],
    yearsInBusiness: json["yearsInBusiness"],
    mcFile: json["mcFile"],
    mcNo: json["mcNo"],
    policyFile: json["policyFile"],
    policyLimit: json["policyLimit"],
    policyNo: json["policyNo"],
    usDotFile: json["usDotFile"],
    usDotNo: json["usDotNo"],
    emergency247: json["emergency24_7"],
    eta: json["eta"],
    primaryCity: json["primaryCity"],
    primaryCountry: json["primaryCountry"],
    regionsCovered: json["regionsCovered"],
    authDate: json["authDate"] == null ? null : DateTime.parse(json["authDate"]),
    authName: json["authName"],
    authSignature: json["authSignature"],
    authTitle: json["authTitle"],
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
    step: json["step"],
    userNo: json["userNo"],
    address: json["address"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "llc": llc,
    "ppm": ppm,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "updatedAt": updatedAt?.toIso8601String(),
    "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
    "companyAddress": companyAddress,
    "companyEmail": companyEmail,
    "companyName": companyName,
    "companyOwner": companyOwner,
    "companyPhone": companyPhone,
    "einNo": einNo,
    "totalTows": totalTows,
    "website": website,
    "yearsInBusiness": yearsInBusiness,
    "mcFile": mcFile,
    "mcNo": mcNo,
    "policyFile": policyFile,
    "policyLimit": policyLimit,
    "policyNo": policyNo,
    "usDotFile": usDotFile,
    "usDotNo": usDotNo,
    "emergency24_7": emergency247,
    "eta": eta,
    "primaryCity": primaryCity,
    "primaryCountry": primaryCountry,
    "regionsCovered": regionsCovered,
    "authDate": "${authDate!.year.toString().padLeft(4, '0')}-${authDate!.month.toString().padLeft(2, '0')}-${authDate!.day.toString().padLeft(2, '0')}",
    "authName": authName,
    "authSignature": authSignature,
    "authTitle": authTitle,
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
    "step": step,
    "userNo": userNo,
    "address": address,
    "phone": phone,
  };
}

class Location {
  final String? type;
  final List? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class Vehicle {
  final int? year;
  final String? brand;
  final String? modelNo;
  final int? gvwr;
  final String? type;
  final String? video;

  Vehicle({
    this.year,
    this.brand,
    this.modelNo,
    this.gvwr,
    this.type,
    this.video,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    year: json["year"],
    brand: json["brand"],
    modelNo: json["modelNo"],
    gvwr: json["gvwr"],
    type: json["type"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "brand": brand,
    "modelNo": modelNo,
    "gvwr": gvwr,
    "type": type,
    "video": video,
  };
}
