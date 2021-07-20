import 'package:flutter/material.dart';
import 'package:flutter_blog/controller/post_controller.dart';
import 'package:flutter_blog/controller/user_controller.dart';
import 'package:flutter_blog/size.dart';
import 'package:flutter_blog/view/pages/post/detail_page.dart';
import 'package:flutter_blog/view/pages/post/write_page.dart';
import 'package:flutter_blog/view/pages/user/login_page.dart';
import 'package:flutter_blog/view/pages/user/user_info.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // put : 없으면 만들고 있으면 찾아서 사용
    // UserController u = Get.put(UserController());
    // find : 있으니까 찾아서 사용
    UserController u = Get.find();

    // homepage에 도착하면 데이터 뿌리기
    // 만들어진 post controller가 없으니 put
    PostController p = Get.put(PostController()); // 객체 생성 (create, initialize)
    p.findAll();

    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.openEndDrawer();
          } else {
            scaffoldKey.currentState!.openDrawer();
          }
        },
        child: Icon(Icons.code),
      ),
      appBar: AppBar(
        title: Text("${u.isLogin}"),
      ),
      drawer: _navigation(context),
      body: Obx(
        () => RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            // onRefresh 가 Future<void> 타입이기 때문에 async 필요
            await p.findAll();
          },
          child: ListView.separated(
            itemCount: p.posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  await p.findById(p.posts[index].id!);
                  Get.to(() => DetailPage(p.posts[index].id),
                      arguments: "arguments 속성 테스트");
                },
                title: Text("${p.posts[index].title}"),
                leading: Text("${p.posts[index].id}"),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ),
    );
  }

  Widget _navigation(BuildContext context) {
    // controller를 class 변수로 선언하거나 필요한 곳에서 찾기
    UserController u = Get.find();
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(() => WritePage());
                },
                child: Text(
                  '글쓰기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  // 페이지 이동할때 drawer 비활성화
                  // Navigator.pop(context); // 제일 위에 쌓인 stack 제거
                  scaffoldKey.currentState!
                      .openEndDrawer(); // scaffold key를 통해 제거
                  Get.to(() => UserInfo());
                },
                child: Text(
                  '회원정보보기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  u.logout();
                  Get.to(() => LoginPage());
                },
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
