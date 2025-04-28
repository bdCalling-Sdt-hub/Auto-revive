class GetAllExperienceModel {
  final String? id;
  final String? adminId;
  final String? name;
  final int? v;

  GetAllExperienceModel({
    this.id,
    this.adminId,
    this.name,
    this.v,
  });

  factory GetAllExperienceModel.fromJson(Map<String, dynamic> json) => GetAllExperienceModel(
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
