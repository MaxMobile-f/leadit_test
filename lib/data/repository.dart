import 'post.dart';
import 'network.dart';

class Repository {
  static Future<List<Post>> getData({int postId}) async {
    return Network.fetchData(postId: postId);
  }
}
