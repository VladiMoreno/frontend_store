import 'package:get/get.dart';

import 'scanner.services.dart';

class ScannerController extends GetxController {
  final ScannerService service = ScannerService();

  var isLoading = RxBool(false);

  getInformationByCode(code) async {
    try {
      final response = await service.getInformationByCode(code);

      response['amount'] = 1;
      response['sub-total'] = response['price'];

      return response;
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
