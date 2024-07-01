import 'general.model.dart';

class SuccessModel extends GeneralModel {
  dynamic data;

  SuccessModel({
    required super.statusCode,
    required super.message,
    required this.data,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data,
      };
}
