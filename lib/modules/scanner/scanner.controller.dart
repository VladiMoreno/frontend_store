import 'package:get/get.dart';

import 'scanner.services.dart';

class ScannerController extends GetxController {
  final ScannerService service = ScannerService();

  var isLoading = RxBool(false);

  getInformationByCode(code) async {
    try {
      await service.getInformationByCode(code);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
