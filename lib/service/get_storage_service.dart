import 'package:get_storage/get_storage.dart';
import 'package:task_for_get_storage/service/log_service.dart';

import '../model/user_model.dart';

class GetStorageService {
  static var box = GetStorage();

  static void storeUser(User user) async {
    box.write('user', user.toJson());
  }

  static User? loadUser() {
    var user = User.fromJson(box.read('user'));
    if (user != null) {
      return user;
    }
    LogService.w('user == null');
    return null;
  }

  static removerUser() {
    box.remove('user');
  }
}
