import 'package:frontend_store/config/states.config.dart';
import 'package:frontend_store/constants/actions_state.constants.dart';
import 'package:get/get.dart';

import 'home.services.dart';

class HomeController extends GetxController {
  final HomeServices services = HomeServices();

  var isLoading = RxBool(false);

  @override
  void onReady() async {
    try {
      isLoading.value = true;

      await services.getBarcodeProducts();

      super.onReady();
    } catch (e) {
      isLoading.value = false;
    } finally {
      AppStates().homeState.action(initialize, []);
      isLoading.value = false;
    }
  }
}
