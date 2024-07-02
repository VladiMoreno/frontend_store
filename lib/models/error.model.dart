import 'general.model.dart';

class ErrorModel extends GeneralModel {
  List<String>? errors;
  String? error;

  ErrorModel({
    required super.statusCode,
    required super.message,
    this.errors,
    this.error,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errors: (json["errors"] as List?)?.map((e) => e as String).toList(),
        error: json["error"] as String?,
      );

  @override
  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errors": errors,
        "error": error,
      };
}
