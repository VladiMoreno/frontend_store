import 'package:frontend_store/config/api_service.config.dart';
import 'package:frontend_store/config/endpoints.config.dart';
import 'package:frontend_store/models/success.model.dart';
import 'package:frontend_store/utils/generate_url.util.dart';
import 'package:frontend_store/utils/logg_message.util.dart';
import 'package:get/get.dart';

class ScannerService extends GetxService {
  final apiservice = APIService();

  Future getInformationByCode(code) async {
    try {
      final params = <String, dynamic>{
        'barcode': code,
      };

      String finalUrl = generateUrl(getProductByCode, params);

      final response = await apiservice.get(finalUrl);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getInformationByCode del archivo scanner.service',
        param: e,
      );
      rethrow;
    }
  }

  Future finishPurchase(List<Map<String, dynamic>> info) async {
    try {
      final data = {
        "id_user": 2,
        "products": info,
      };

      final response = await apiservice.post(addPurchase, data: data);

      SuccessModel successModel = SuccessModel.fromJson(response);

      return successModel.data;
    } catch (e) {
      printMessageParam(
        message:
            'Error en la función getInformationByCode del archivo scanner.service',
        param: e,
      );
      rethrow;
    }
  }
}
