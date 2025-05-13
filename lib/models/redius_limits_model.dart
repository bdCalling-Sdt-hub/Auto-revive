class RadiusLimitsModel {
  final String? id;
  final String? key;
  final int? v;
  final Value? value;

  RadiusLimitsModel({
    this.id,
    this.key,
    this.v,
    this.value,
  });

  factory RadiusLimitsModel.fromJson(Map<String, dynamic> json) => RadiusLimitsModel(
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
  final int? min;
  final int? max;

  Value({
    this.min,
    this.max,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
  };
}
