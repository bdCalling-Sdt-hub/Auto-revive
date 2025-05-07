

class CarModel {
  final String? id;
  final String? adminId;
  final String? name;
  final int? v;

  CarModel({
    this.id,
    this.adminId,
    this.name,
    this.v,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
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
