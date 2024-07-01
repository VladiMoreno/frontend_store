import 'package:get_storage/get_storage.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  static Future<void> init() async {
    await GetStorage.init();
  }

  GetStorage get storage => GetStorage();
}
