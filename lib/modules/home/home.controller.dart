import 'package:frontend_store/config/states.config.dart';
import 'package:frontend_store/constants/actions_state.constants.dart';
import 'package:frontend_store/utils/catch_error.util.dart';
import 'package:get/get.dart';

import 'home.services.dart';

class HomeController extends GetxController {
  final HomeServices services = HomeServices();

  var isLoading = RxBool(false);
  var info = RxList([]);

  @override
  void onReady() async {
    try {
      isLoading.value = true;

      final response = await services.getBarcodeProducts();

      info.value = response;

      super.onReady();
    } catch (e) {
      isLoading.value = false;
      CatchErrorManagement(
        error: e,
      );
    } finally {
      AppStates().homeState.action(initialize, []);
      isLoading.value = false;
    }
  }
}
