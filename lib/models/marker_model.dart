
class MarkerModels {
  final String id;
  final String name;
  final String profileImage;
  final List<double> coordinates;

  MarkerModels({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.coordinates,
  });

  factory MarkerModels.fromJson(Map<String, dynamic> json) {
    return MarkerModels(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? json['name'] ?? '',
      profileImage: json['profileImage'] ?? json['profileImage'] ?? '',
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'coordinates': coordinates,
    };
  }
}
