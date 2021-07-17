import 'package:intl/intl.dart';

class User {
  // final은 반드시 초기화가 필요
  final int? id;
  final String? username;
  final String? email;
  final DateTime? created;
  final DateTime? updated;

  // 선택적 매개변수
  User({
    this.id,
    this.username,
    this.email,
    this.created,
    this.updated,
  });

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트
  // 이름있는 생성자
  // 날짜 포맷
  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        email = json["email"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}
