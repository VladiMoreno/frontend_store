import 'package:dio/dio.dart';
import 'package:frontend_store/interceptors/main.interceptor.dart';
import 'package:frontend_store/utils/logg_message.util.dart';

import 'env.config.dart';

class APIService {
  final dio = Dio();

  APIService() {
    dio.interceptors.add(MainInterceptor());

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json, image/png',
    };
  }

  Future call(String method, String path, {dynamic body}) async {
    try {
      switch (method) {
        case 'GET':
          return await dio.get('$baseUrl$path').then((value) => value.data);
        case 'POST':
          return await dio
              .post('$baseUrl$path', data: body)
              .then((value) => value.data);
        case 'PUT':
          return await dio
              .put('$baseUrl$path', data: body)
              .then((value) => value.data);
        case 'DELETE':
          return await dio.delete('$baseUrl$path').then((value) => value.data);
        case 'GET_FULL_URL':
          return await dio.get(path).then((value) => value.data);
        default:
          throw Exception('Método HTTP no válido: $method');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionError) {
          printErrorLog(error: e.message, typeError: 'connectionError');
          rethrow;
        } else if (e.type == DioExceptionType.badResponse) {
          printErrorLog(error: e.message, typeError: 'badResponse');
          rethrow;
        } else if (e.type == DioExceptionType.cancel) {
          printErrorLog(error: e.message, typeError: 'cancel');
          rethrow;
        } else {
          printErrorLog(error: e.message, typeError: e.type);
          rethrow;
        }
      } else {
        printErrorLog(error: e, typeError: '');
        rethrow;
      }
    }
  }

  // Función para generar funciones de API dinámicamente
  Function(String path, {dynamic data}) generateFunction(String method) {
    return (String path, {dynamic data}) {
      return call(method, path, body: data);
    };
  }

  // Generar funciones para los métodos HTTP comunes
  Function(String path, {dynamic data}) get get => generateFunction('GET');
  Function(String path, {dynamic data}) get post => generateFunction('POST');
  Function(String path, {dynamic data}) get put => generateFunction('PUT');
  Function(String path, {dynamic data}) get delete =>
      generateFunction('DELETE');

  Function(String path, {dynamic data}) get getFullURL =>
      generateFunction('GET_FULL_URL');
}
