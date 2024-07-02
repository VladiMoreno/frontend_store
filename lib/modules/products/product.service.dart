import 'package:frontend_store/config/api_service.config.dart';
import 'package:frontend_store/config/endpoints.config.dart';
import 'package:frontend_store/models/success.model.dart';
import 'package:frontend_store/utils/generate_url.util.dart';
import 'package:frontend_store/utils/logg_message.util.dart';
import 'package:get/get.dart';

class ProductService extends GetxService {
  final apiservice = APIService();

  Future getAllProducts() async {
    try {
      final response = await apiservice.get(getProducts);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getAllProducts del archivo product.service',
        param: e,
      );
      rethrow;
    }
  }

  Future updateProductInformation(Map<String, dynamic> info) async {
    try {
      final params = <String, dynamic>{
        'id_product': info['id'],
      };

      String finalUrl = generateUrl(updateProduct, params);

      final response = await apiservice.put(finalUrl, data: info);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función updateProductInformation del archivo product.service',
        param: e,
      );
      rethrow;
    }
  }
}
