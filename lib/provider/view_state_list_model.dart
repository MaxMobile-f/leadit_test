import 'view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel {
  /// Page data
  List<T> list = [];

  initData() async {
    setBusy();
    await refresh(init: true);
  }

  // Pull down to refresh
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();

      onCompleted(data);
      list.clear();
      list.addAll(data);
      setIdle();
    } catch (e, s) {
      if (init) list.clear();
      setError(e, s);
    }
  }

  // Download Data
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}
