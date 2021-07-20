import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/util/validator_util.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/pages/post/home_page.dart';
import 'package:flutter_blog/view/pages/user/join_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final UserController u = Get.put(UserController());

  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "로그인 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _loginForm(),
            TextButton(
              onPressed: () {
                Get.to(JoinPage());
              },
              child: Text("아직 회원가입이 안되어 있나요?"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _username,
            hint: "Username",
            funValidator: validatorUsername(),
          ),
          CustomTextFormField(
            controller: _password,
            hint: "Password",
            funValidator: validatorPassword(),
          ),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () async {
              _formKey.currentState!.validate();
              // Get.to(HomePage());
              // trim() : 공백제거
              // TextEditingController로 텍스트 받아올수있음
              String token =
                  await u.login(_username.text.trim(), _password.text.trim());
              if (token != "-1") {
                // print("토큰 정상적으로 받음");
                Get.to(() => HomePage());
              } else {
                // print("토큰 못받음");
                Get.snackbar("로그인 시도", "로그인 실패");
              }
            },
          ),
        ],
      ),
    );
  }
}
