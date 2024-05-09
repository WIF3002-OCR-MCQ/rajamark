import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserState extends GetxService {
  static UserState get to => Get.find();

  User? _currentUser;

  void removeUser() {
    _currentUser = null;
  }

  void updateUser(User user) {
    _currentUser = user;
  }

  User? getUser() {
    return _currentUser;
  }
}
