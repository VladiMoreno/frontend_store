import 'package:get/get.dart';

import 'carts.services.dart';

class CartsController extends GetxController {
  final CartsService service = CartsService();

  var isLoading = RxBool(false);
  var info = RxList([]);

  @override
  void onReady() async {
    try {
      isLoading.value = true;

      final response = await service.getAllPurchases();

      info.value = response;
      super.onReady();
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  getDetailPurchase(int id) async {
    try {
      isLoading.value = true;

      return await service.getDetailPurchase(id);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
