import 'package:flutter/material.dart';
import 'package:leadit_test/data/post.dart';
import 'package:leadit_test/data/post_model.dart';
import 'package:leadit_test/provider/provider_widget.dart';
import 'package:leadit_test/ui/widgets/custom_refresher_footer.dart';
import 'package:leadit_test/ui/widgets/post_card.dart';
import 'package:leadit_test/ui/widgets/view_state_busy_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/view_state_error_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ProviderWidget<PostListModel>(
                onModelReady: (model) async {
                  await model.initData();
                },
                model: PostListModel(),
                builder: (context, model, child) {
                  if (model.busy) {
                    return ViewStateBusyWidget();
                  } else if (model.error && model.list.isEmpty) {
                    return ViewStateErrorWidget(onPressed: model.initData);
                  }
                  return SmartRefresher(
                    enablePullDown: false,
                    controller: model.refreshController,
                    footer: CustomRefresherFooter(),
                    onLoading: () async {
                      await model.loadMore();
                    },
                    enablePullUp: true,
                    child: ListView.builder(
                        itemCount: model.list.length,
                        itemBuilder: (context, index) {
                          Post post = model.list[index];
                          return PostCard(
                            id: post.id,
                            name: post.name,
                            email: post.email,
                            body: post.body,
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
