import 'package:flutter/material.dart';
import 'package:flutter_blog/util/validator_util.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/components/custom_textarea.dart';
import 'package:get/get.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                hint: "Title",
                funValidator: validatorTitle(),
                value: "제목1" * 2,
              ),
              CustomTextarea(
                hint: "content",
                funValidator: validatorContent(),
                value: "내용1" * 30,
              ),
              CustomElevatedButton(
                text: "글 수정하기",
                funPageRoute: () {
                  _formKey.currentState!.validate();
                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
