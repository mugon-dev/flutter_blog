import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/controller/dto/JoinReqDto.dart';
import 'package:flutter_blog/controller/dto/loginReqDto.dart';
import 'package:flutter_blog/domain/user/user.dart';
import 'package:flutter_blog/domain/user/user_provider.dart';
import 'package:flutter_blog/util/convert_utf8.dart';
import 'package:flutter_blog/util/jwt.dart';
import 'package:get/get.dart';

// 통신을 호출해서 응답되는 데이터를 가공 : json => Dart 오브젝트
class UserRepository {
  final UserProvider _userProvider = UserProvider();

  Future<User> join(String username, String password, String email) async {
    JoinReqDto joinReqDto = JoinReqDto(username, password, email);
    Response response = await _userProvider.join(joinReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    print(cmRespDto.code);
    if (cmRespDto.code == 1) {
      User principal = User.fromJson(cmRespDto.data);
      return principal;
    } else {
      return User();
    }
  }

  Future<User> login(String username, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(username, password);
    Response response = await _userProvider.login(loginReqDto.toJson());
    dynamic headers = response.headers;
    dynamic body = response.body;
    // if (headers["authorization"] == null) {
    //   return "-1";
    // } else {
    //   String token = headers["authorization"];
    //   return token;
    // }
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      User principal = User.fromJson(cmRespDto.data);
      String token = headers["authorization"];
      jwtToken = token;
      return principal;
    } else {
      return User();
    }
  }
}
