import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GlobalService extends GetxService {
  static GlobalService get to => Get.find();



  // final RxBool _isDarkMode = true.obs;
  // bool get isDarkMode => _isDarkMode.value;

  // void switchThemeModel() {
  //   _isDarkMode.value = !_isDarkMode.value;
  // }

  

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
