import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    // String data = Get.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Detail Page $id"),
      ),
    );
  }
}
