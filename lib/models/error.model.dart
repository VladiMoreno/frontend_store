import 'general.model.dart';

class ErrorModel extends GeneralModel {
  List<String>? errors;
  String? error;

  ErrorModel({
    required super.statusCode,
    required super.message,
    this.errors = const [''],
    this.error = '',
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errors: json["errors"],
        error: json["error"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errors": errors,
        "error": error,
      };
}
