import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/features/auth/presentation/controller/auth_controller.dart';
import 'package:social_app/src/features/home/presentation/components/shimmer_like.dart';

import '../../../../routes/app_pages.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../domain/entities/comment.dart';
import '../components/comment_widget.dart';
import '../controller/home_controller.dart';

class PostCommentsScreen extends GetView<HomeController> {
  final String postId;
  const PostCommentsScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getAllPostComment(postId);
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    HomeController homeCtrl = AppGet.homeGet;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppText('Comments'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => AppNavigator.pop,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
        ),
      ),
      body: Form(
        key: keyForm,
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<HomeController>(builder: (homeController) {
                return GetBuilder<AuthController>(builder: (authController) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemCount: homeController.postComments.length,
                      itemBuilder: (context, i) {
                        Comment commentData = homeController.postComments[i];
                        return FutureBuilder<Auth>(
                            future: authController
                                .fetchInfoUserById(commentData.userId),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? CommentWidget(
                                      type: "post",
                                      commentData: commentData,
                                      userData: snapshot.data!,
                                      uid: postId,
                                    )
                                  : const CustomShimmerLike();
                            });
                      });
                });
              }),
            ),
            Container(
              height: 70,
              decoration: const BoxDecoration(
                  color: Color(0xff1F2128),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(18.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: TextField(
                          controller: homeCtrl.postCommentController,
                          style: const TextStyle(
                              // GoogleFonts.roboto(
                              // 'Roboto',
                              color: Colors.white),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10.0),
                            hintText: 'Enter your commnet',
                            hintStyle: TextStyle(
                                // GoogleFonts.roboto(
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          homeCtrl.addCommentPost(
                            postId,
                            homeCtrl.postCommentController.text,
                          );
                          homeCtrl.postCommentController.text = '';
                        }
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
