import 'package:frontend_store/constants/type_notification.constants.dart';
import 'package:frontend_store/utils/catch_error.util.dart';
import 'package:frontend_store/utils/notifications.util.dart';
import 'package:get/get.dart';

import 'scanner.services.dart';

class ScannerController extends GetxController {
  final ScannerService service = ScannerService();

  var isLoading = RxBool(false);

  getInformationByCode(code) async {
    try {
      isLoading.value = true;

      final response = await service.getInformationByCode(code);

      response['amount'] = 1;
      response['sub-total'] = response['price'];

      return response;
    } catch (e) {
      isLoading.value = false;
      CatchErrorManagement(
        error: e,
      );
    } finally {
      isLoading.value = false;
    }
  }

  finishPurchase(List<Map<String, dynamic>> info) async {
    try {
      isLoading.value = true;

      final response = await service.finishPurchase(info);

      Notifications(
        typeProcess: TypeNotification.simpleNotification,
        typeNotification: 'success',
        titleNotification: 'Éxito!',
        textNotification: 'Venta realizada',
      );

      return response;
    } catch (e) {
      isLoading.value = false;
      CatchErrorManagement(
        error: e,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
