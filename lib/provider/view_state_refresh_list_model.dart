import 'package:leadit_test/provider/view_state_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  /// Page一 Page number
  static const int pageNumFirst = 1;

  /// Number of paged entries
  static const int pageSize = 5;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// Current page number
  int _currentPageNum = pageNumFirst;

  /// Pull down to refresh

  Future<List<T>> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      var data = await loadData(postId: pageNumFirst);

      onCompleted(data);
      list.clear();
      list.addAll(data);
      refreshController.refreshCompleted();
      if (data.length < pageSize) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      setIdle();
      return data;
    } catch (e, s) {
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  /// Pull up to load more
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(postId: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      print('error--->\n  $e');
      print('stack--->\n  $s');
      return null;
    }
  }

  //Download Data
  Future<List<T>> loadData({int postId});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
