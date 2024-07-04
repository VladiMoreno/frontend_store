import 'package:frontend_store/config/api_service.config.dart';
import 'package:frontend_store/config/endpoints.config.dart';
import 'package:frontend_store/models/success.model.dart';
import 'package:frontend_store/utils/generate_url.util.dart';
import 'package:frontend_store/utils/logg_message.util.dart';
import 'package:get/get.dart';

class CartsService extends GetxService {
  final apiservice = APIService();

  Future getAllPurchases() async {
    try {
      final response = await apiservice.get(getPurchases);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getAllPurchases del archivo carts.service',
        param: e,
      );
      rethrow;
    }
  }

  Future getDetailPurchase(int id) async {
    try {
      final params = <String, dynamic>{
        'id_cart': id,
      };

      String finalUrl = generateUrl(getDetailPurchaseURL, params);

      final response = await apiservice.get(finalUrl);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getDetailPurchase del archivo carts.service',
        param: e,
      );
      rethrow;
    }
  }
}
