import 'package:frontend_store/constants/actions_state.constants.dart';

class HomeState {
  bool isInitialized = false;
  List info = [];

  void reset() {
    isInitialized = false;
    info = [];
  }

  void action(option, data) {
    switch (option) {
      case initialize:
        isInitialized = true;
        break;
      case set:
        info = data;
        break;
      case add:
        info.addAll(data);
        break;
    }
  }
}
