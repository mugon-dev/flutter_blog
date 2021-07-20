import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/util/validator_util.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/pages/user/login_page.dart';
import 'package:get/get.dart';

class JoinPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

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
                "회원가입 페이지",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            _joinForm(),
          ],
        ),
      ),
    );
  }

  Widget _joinForm() {
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
          CustomTextFormField(
            controller: _email,
            hint: "Email",
            funValidator: validatorEmail(),
          ),
          CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () async {
              // 현재 상태의 validate 검사
              if (_formKey.currentState!.validate()) {
                int result = await Get.find<UserController>().join(
                    _username.text.trim(),
                    _password.text.trim(),
                    _email.text.trim());
                if (result == 1) {
                  Get.to(() => LoginPage());
                } else {
                  Get.snackbar("회원가입 시도", "회원가입 실패");
                }
              }
            },
          ),
          TextButton(
            onPressed: () {
              Get.to(() => LoginPage());
            },
            child: Text("로그인 페이지로 이동"),
          ),
        ],
      ),
    );
  }
}
