import 'package:flutter_blog/util/jwt.dart';
import 'package:get/get.dart';

const host = "http://192.168.0.157:8080";

// 역할 : 통신
class PostProvider extends GetConnect {
  // Promise (데이터 약속)
  // 목록보기
  Future<Response> findAll() => get("$host/post", headers: {
        "Authorization": jwtToken ?? "",
      });
}
