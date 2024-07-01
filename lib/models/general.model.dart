class GeneralModel {
  int statusCode;
  String message;

  GeneralModel({
    required this.statusCode,
    required this.message,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
