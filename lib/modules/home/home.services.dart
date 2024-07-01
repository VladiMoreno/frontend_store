import 'package:frontend_store/config/api_service.config.dart';
import 'package:frontend_store/config/endpoints.config.dart';
import 'package:frontend_store/models/success.model.dart';
import 'package:frontend_store/utils/logg_message.util.dart';
import 'package:get/get.dart';

class HomeServices extends GetxService {
  final apiservice = APIService();

  Future getBarcodeProducts() async {
    try {
      SuccessModel response = await apiservice.get(getProducts);

      return response.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getBarcodeProducts del archivo home.service',
        param: e,
      );
      rethrow;
    }
  }
}
