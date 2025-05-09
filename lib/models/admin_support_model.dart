class AdminSupportModel {
  final String? id;
  final String? key;
  final int? v;
  final Value? value;

  AdminSupportModel({
    this.id,
    this.key,
    this.v,
    this.value,
  });

  factory AdminSupportModel.fromJson(Map<String, dynamic> json) => AdminSupportModel(
    id: json["_id"],
    key: json["key"],
    v: json["__v"],
    value: json["value"] == null ? null : Value.fromJson(json["value"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "key": key,
    "__v": v,
    "value": value?.toJson(),
  };
}

class Value {
  final String? details;
  final String? phone;
  final String? email;

  Value({
    this.details,
    this.phone,
    this.email,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    details: json["details"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
    "phone": phone,
    "email": email,
  };
}
