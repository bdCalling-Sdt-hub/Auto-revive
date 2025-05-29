class PaymentHistoryModel {
  final String? id;
  final String? customerId;
  final String? providerId;
  final String? jobProcessId;
  final String? type;
  final int? amount;
  final bool? isRefundRequested;
  final List<dynamic>? refundImages;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? paymentType;

  PaymentHistoryModel({
    this.id,
    this.customerId,
    this.providerId,
    this.jobProcessId,
    this.type,
    this.amount,
    this.isRefundRequested,
    this.refundImages,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.paymentType,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    id: json["_id"],
    customerId: json["customerId"],
    providerId: json["providerId"],
    jobProcessId: json["jobProcessId"],
    type: json["type"],
    amount: json["amount"],
    isRefundRequested: json["isRefundRequested"],
    refundImages: json["refundImages"] == null ? [] : List<dynamic>.from(json["refundImages"]!.map((x) => x)),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    paymentType: json["paymentType"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId,
    "providerId": providerId,
    "jobProcessId": jobProcessId,
    "type": type,
    "amount": amount,
    "isRefundRequested": isRefundRequested,
    "refundImages": refundImages == null ? [] : List<dynamic>.from(refundImages!.map((x) => x)),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "paymentType": paymentType,
  };
}
