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

  agregarProducto(Map<String, dynamic> newProduct) async {
    try {
      isLoading.value = true;

      final response = await service.addProductInformation(newProduct);

      info.insert(0, response);
      info.refresh();
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  actualizarProducto(Map<String, dynamic> updatedInfo) async {
    try {
      isLoading.value = true;

      final response = await service.updateProductInformation(updatedInfo);

      for (var element in info) {
        if (element['id'] == response['id']) {
          element['name'] = response['name'];
          element['price'] = response['price'];
        }
      }

      info.refresh();
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

      info.removeWhere((element) => element['id'] == int.parse(id));
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
