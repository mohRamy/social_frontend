import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import 'package:social_app/src/features/home/presentation/components/post_widget.dart';
import 'package:social_app/src/features/home/presentation/controller/home_controller.dart';

import '../components/online_widget.dart';
import '../../../../core/widgets/separator_widget.dart';
import '../components/stories_widget.dart';
import '../components/write_something_widget.dart';

class HomeTab extends GetView<HomeController> {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          return Column(
            children: <Widget>[
              const WriteSomethingWidget(),
              SeparatorWidget(),
              OnlineWidget(),
              SeparatorWidget(),
              StoriesWidget(),
              for (PostModel post in homeCtrl.posts)
                Column(
                  children: <Widget>[
                    SeparatorWidget(),
                    PostWidget(post: post),
                  ],
                ),
              SeparatorWidget(),
            ],
          );
        }
      ),
    );
  }
}
