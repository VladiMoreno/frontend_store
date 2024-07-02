import 'package:frontend_store/config/states.config.dart';
import 'package:frontend_store/constants/actions_state.constants.dart';
import 'package:get/get.dart';

import 'product.service.dart';

class ProductController extends GetxController {
  final ProductService service = ProductService();

  var isLoading = RxBool(false);
  var info = RxList([]);

  @override
  void onReady() async {
    try {
      isLoading.value = true;

      final response = await service.getAllProducts();

      info.value = response;

      super.onReady();
    } catch (e) {
      isLoading.value = false;
    } finally {
      AppStates().productState.action(initialize, []);
      isLoading.value = false;
    }
  }

  agregarProducto(Map<String, dynamic> info) async {
    try {
      isLoading.value = true;

      await service.addProductInformation(info);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  actualizarProducto(Map<String, dynamic> info) async {
    try {
      isLoading.value = true;

      await service.updateProductInformation(info);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  eliminarProducto(String id) async {
    try {
      isLoading.value = true;

      await service.removeProductInformation(id);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
