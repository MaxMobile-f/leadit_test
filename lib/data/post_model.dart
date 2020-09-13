import 'package:leadit_test/data/post.dart';
import 'package:leadit_test/data/repository.dart';
import 'package:leadit_test/provider/view_state_refresh_list_model.dart';

class PostListModel extends ViewStateRefreshListModel<Post> {

  @override
  Future<List<Post>> loadData({int postId}) async {
    return await Repository.getData(postId: postId);
  }
}
