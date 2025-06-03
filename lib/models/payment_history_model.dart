class PaymentHistoryModel {
  final int? wallet;
  final List<History>? history;

  PaymentHistoryModel({
    this.wallet,
    this.history,
  });

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    wallet: json["wallet"],
    history: json["history"] == null
        ? []
        : List<History>.from(json["history"].map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wallet": wallet,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
  };
}

class History {
  final String? trId;
  final DateTime? createdAt;
  final int? amount;
  final Title? title;
  final String? rawTitle;
  final Image? image;
  final String? rawImage;
  final Status? status;
  final String? rawStatus;

  History({
    this.trId,
    this.createdAt,
    this.amount,
    this.title,
    this.rawTitle,
    this.image,
    this.rawImage,
    this.status,
    this.rawStatus,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    final String? titleStr = json["title"];
    final String? imageStr = json["image"];
    final String? statusStr = json["status"];

    return History(
      trId: json["trId"],
      createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      amount: json["amount"],
      title: titleValues.map[titleStr],
      rawTitle: titleStr,
      image: imageValues.map[imageStr],
      rawImage: imageStr,
      status: statusValues.map[statusStr],
      rawStatus: statusStr,
    );
  }

  Map<String, dynamic> toJson() => {
    "trId": trId,
    "createdAt": createdAt?.toIso8601String(),
    "amount": amount,
    "title": title != null ? titleValues.reverse[title] : rawTitle,
    "image": image != null ? imageValues.reverse[image] : rawImage,
    "status": status != null ? statusValues.reverse[status] : rawStatus,
  };
}

enum Image {
  DEFAULTS_WALLET_ADD_PNG,
  E0295420_F841_438_C_A8_A9_4_D06_B5_ABB70_A_JPG,
  THE_3152_F312_AA73_49429_FA9_C872_FFADDBFD_JPG,
  THE_35597_FCC_365040_F3_B246_738_D30_DC0827_JPG,
  THE_9_EEB3322_D017_4_B5_D_A337_1_F629_B9_E02_AC_JPG
}

final imageValues = EnumValues({
  "defaults/wallet-add.png": Image.DEFAULTS_WALLET_ADD_PNG,
  "e0295420-f841-438c-a8a9-4d06b5abb70a.jpg": Image.E0295420_F841_438_C_A8_A9_4_D06_B5_ABB70_A_JPG,
  "3152f312-aa73-4942-9fa9-c872ffaddbfd.jpg": Image.THE_3152_F312_AA73_49429_FA9_C872_FFADDBFD_JPG,
  "35597fcc-3650-40f3-b246-738d30dc0827.jpg": Image.THE_35597_FCC_365040_F3_B246_738_D30_DC0827_JPG,
  "9eeb3322-d017-4b5d-a337-1f629b9e02ac.jpg": Image.THE_9_EEB3322_D017_4_B5_D_A337_1_F629_B9_E02_AC_JPG,
});

enum Status { CREATED, PENDING, SUCCESS }

final statusValues = EnumValues({
  "created": Status.CREATED,
  "pending": Status.PENDING,
  "success": Status.SUCCESS
});

enum Title {
  ADD_BALANCE,
  SEND_TO_BISWAS,
  SEND_TO_EBRAHIM,
  SEND_TO_MR_TOW_TRUCK,
  SEND_TO_POKAYO
}

final titleValues = EnumValues({
  "Add Balance": Title.ADD_BALANCE,
  "Send to Biswas": Title.SEND_TO_BISWAS,
  "Send to Ebrahim": Title.SEND_TO_EBRAHIM,
  "Send to Mr. Tow Truck": Title.SEND_TO_MR_TOW_TRUCK,
  "Send to pokayo": Title.SEND_TO_POKAYO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
