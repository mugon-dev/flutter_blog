import 'package:flutter_blog/domain/user/user.dart';
import 'package:flutter_blog/domain/user/user_repository.dart';
import 'package:flutter_blog/util/jwt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  // 로그인 상태
  final RxBool isLogin = false.obs; // Rx : 관찰 가능한 변수 => 변경 감지 => UI가 자동 업데이트

  final principal = User().obs;
  void logout() {
    this.isLogin.value = false;
    jwtToken = null;
  }

  Future<int> login(String username, String password) async {
    // String token = await _userRepository.login(username, password);
    User principal = await _userRepository.login(username, password);

    // 토근 관리 : shared preference 에 저장하면 앱이 꺼져도 남아있음, 파일로 저장하면 앱이 꺼지만 다시 받아와야함
    // if (token != "-1") {
    //   isLogin.value = true;
    //   jwtToken = token;
    //   print(jwtToken);
    // }
    // return token;
    if (principal.id != null) {
      this.isLogin.value = true;
      this.principal.value = principal;
      return 1;
    } else {
      return -1;
    }
  }
}
