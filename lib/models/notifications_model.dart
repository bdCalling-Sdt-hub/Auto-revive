class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String receiverId;
  final bool viewStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.receiverId,
    required this.viewStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      receiverId: json['receiverId'] as String,
      viewStatus: json['viewStatus'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'message': message,
      'receiverId': receiverId,
      'viewStatus': viewStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? receiverId,
    bool? viewStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        message: message ?? this.message,
        receiverId: receiverId ?? this.receiverId,
        viewStatus: viewStatus ?? this.viewStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );
}
