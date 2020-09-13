import 'package:dio/dio.dart';
import 'package:leadit_test/data/post.dart';

class Network {
  static Future<List<Post>> fetchData({int postId}) async {
    try {
      final response = await Dio()
          .get('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      return response.data.map<Post>((item) => Post.fromJson(item)).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
