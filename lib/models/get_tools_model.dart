class GetAllToolsModel {
  final String? groupName;
  final List<ToolModel> tools;

  GetAllToolsModel({
    this.groupName,
    required this.tools,
  });

  factory GetAllToolsModel.fromJson(Map<String, dynamic> json) {
    return GetAllToolsModel(
      groupName: json['_id'],
      tools: List<ToolModel>.from(json['tools'].map((x) => ToolModel.fromJson(x))),
    );
  }
}

class ToolModel {
  final String? id;
  final String? name;
  bool isSelected; // <-- added this field

  ToolModel({
    this.id,
    this.name,
    this.isSelected = false, // <-- initialize with default value
  });

  factory ToolModel.fromJson(Map<String, dynamic> json) {
    return ToolModel(
      id: json['_id'],
      name: json['name'],
    );
  }
}
