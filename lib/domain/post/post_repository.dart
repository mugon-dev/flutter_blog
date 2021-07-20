import 'package:flutter_blog/controller/dto/CMRespDto.dart';
import 'package:flutter_blog/controller/dto/SaveOrUpdateReqDto.dart';
import 'package:flutter_blog/domain/post/post.dart';
import 'package:flutter_blog/domain/post/post_provider.dart';
import 'package:flutter_blog/util/convert_utf8.dart';
import 'package:get/get.dart';

// 통신을 호출해서 응답되는 데이터를 가공 : json => Dart 오브젝트
class PostRepository {
  final PostProvider _postProvider = PostProvider();

  Future<Post> save(String title, String content) async {
    SaveOrUpdateReqDto saveReqDto = SaveOrUpdateReqDto(title, content);
    Response response = await _postProvider.save(saveReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    if (cmRespDto.code == 1) {
      print("글쓰기 성공");
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      print("글쓰기 실패");
      return Post();
    }
  }

  Future<Post> updateById(int id, String title, String content) async {
    SaveOrUpdateReqDto updateReqDto = SaveOrUpdateReqDto(title, content);
    Response response =
        await _postProvider.updateById(id, updateReqDto.toJson());
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    if (cmRespDto.code == 1) {
      print("수정 성공");
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      print("수정 실패");
      return Post();
    }
  }

  Future<int> deleteById(int id) async {
    Response response = await _postProvider.deleteById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);

    return cmRespDto.code!;
  }

  Future<Post> findById(int id) async {
    Response response = await _postProvider.findById(id);
    dynamic body = response.body;
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    if (cmRespDto.code == 1) {
      Post post = Post.fromJson(cmRespDto.data);
      return post;
    } else {
      return Post();
    }
  }

  Future<List<Post>> findAll() async {
    Response response = await _postProvider.findAll();
    dynamic body = response.body;
    // UTF-8 한글 깨짐 해결
    dynamic convertBody = convertUtf8ToObject(body);
    CMRespDto cmRespDto = CMRespDto.fromJson(convertBody);
    // print(cmRespDto.code);
    // print(cmRespDto.msg);
    // print(cmRespDto.data.runtimeType);
    if (cmRespDto.code == 1) {
      // 데이터 불러오기 성공
      // 실행해야 데이터 타입이 정해지니 temp로 데이터 타입 미리 지정
      List<dynamic> temp = cmRespDto.data;
      List<Post> posts = temp.map((post) => Post.fromJson(post)).toList();
      // print(posts.length);
      // print(posts[0].title);
      return posts;
    } else {
      // 불러오기 실패했을때 빈배열 넘겨줌
      return <Post>[];
    }
  }
}
