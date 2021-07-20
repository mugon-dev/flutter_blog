import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/post_controller.dart';
import 'package:flutter_blog/util/validator_util.dart';
import 'package:flutter_blog/view/components/custom_elevated_button.dart';
import 'package:flutter_blog/view/components/custom_text_form_field.dart';
import 'package:flutter_blog/view/components/custom_textarea.dart';
import 'package:get/get.dart';

class UpdatePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PostController p = Get.find();
    _title.text = "${p.post.value.title}";
    _content.text = "${p.post.value.content}";

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _title,
                hint: "Title",
                funValidator: validatorTitle(),
              ),
              CustomTextarea(
                controller: _content,
                hint: "content",
                funValidator: validatorContent(),
              ),
              CustomElevatedButton(
                text: "글 수정하기",
                funPageRoute: () {
                  _formKey.currentState!.validate();
                  p.updateById(p.post.value.id!, _title.text, _content.text);
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
