import 'package:get/get.dart';

import 'user.service.dart';

class UserController extends GetxController {
  final UserService service = UserService();

  var isLoading = RxBool(false);
}
