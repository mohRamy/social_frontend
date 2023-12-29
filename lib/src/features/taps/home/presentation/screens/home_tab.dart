import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/widgets/separator_widget.dart';
import '../../data/models/post_model.dart';
import '../../../../../core/widgets/post_widget.dart';
import '../components/stories_widget.dart';
import '../components/write_something_widget.dart';
import '../controllers/home_controller.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  Future<void> _loadResources() async {
    await AppGet.homeGet.getAllPosts();
    await AppGet.homeGet.getAllStories();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadResources();
      },
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: <Widget>[
              const WriteSomethingWidget(),
              const SeparatorWidget(),
              const StoriesWidget(),
              ListView.builder(
                itemCount: AppGet.homeGet.posts.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  PostModel post = AppGet.homeGet.posts[index];
                  return Column(
                    children: <Widget>[
                      const SeparatorWidget(),
                      PostWidget(
                        postData: post,
                        index: index,
                      ),
                    ],
                  );
                },
              ),
              const SeparatorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
