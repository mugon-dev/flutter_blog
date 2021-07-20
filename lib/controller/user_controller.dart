import 'package:flutter_blog/domain/user/user_repository.dart';
import 'package:flutter_blog/util/jwt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  Future<String> login(String username, String password) async {
    String token = await _userRepository.login(username, password);
    // 토근 관리 : shared preference 에 저장하면 앱이 꺼져도 남아있음, 파일로 저장하면 앱이 꺼지만 다시 받아와야함
    if (token != "-1") {
      jwtToken = token;
      print(jwtToken);
    }
    return token;
  }
}
