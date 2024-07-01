import 'package:dio/dio.dart';
import 'package:frontend_store/models/general.model.dart';
import 'package:frontend_store/models/success.model.dart';
import 'package:frontend_store/models/error.model.dart';

class MainInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final cancelToken = CancelToken();
    options.cancelToken = cancelToken;

    Future.delayed(const Duration(seconds: 10), () {
      if (!cancelToken.isCancelled) {
        cancelToken.cancel('Solicitud cancelada debido a tiempo de espera.');
      }
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      final json = response.data;
      GeneralModel generalModel = GeneralModel.fromJson(json);

      switch (generalModel.statusCode) {
        case 200:
          SuccessModel successModel = SuccessModel.fromJson(json);
          response.data = successModel.toJson();
          return super.onResponse(response, handler);
        case 201:
          SuccessModel successModel = SuccessModel.fromJson(json);
          response.data = successModel.toJson();
          return super.onResponse(response, handler);
        default:
          ErrorModel errorModel = ErrorModel.fromJson(json);
          response.data = errorModel.toJson();
          return super.onResponse(response, handler);
      }
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(),
        response: response,
        message: 'Ah ocurrido un error en la respuesta del servidor.',
        type: DioExceptionType.unknown,
      );
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      final json = err.response!.data;
      final generalResponse = err.response!.statusCode;

      final errorModel = ErrorModel.fromJson(json);

      switch (generalResponse) {
        case 404:
          final error = DioException(
            message: errorModel.error,
            response: err.response,
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions(),
          );
          super.onError(error, handler);
          break;
        case 422:
          final error = DioException(
            error: errorModel.errors,
            response: err.response,
            type: DioExceptionType.badResponse,
            requestOptions: RequestOptions(),
          );
          super.onError(error, handler);
          break;
      }
    } catch (e) {
      super.onError(
        DioException(
          message: "Ah ocurrido un error en la respuesta del servidor",
          response: err.response,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(),
        ),
        handler,
      );
    }
  }
}
