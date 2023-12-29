import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../../../core/widgets/app_text.dart';
import '../../../../taps/home/presentation/components/shimmer_like.dart';
import '../controllers/comment_controller.dart';

import '../../../../../routes/app_pages.dart';
import '../components/comment_widget.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/comment.dart';

class CommentScreen extends GetView<CommentController> {
  final String itemId;
  final String itemType;
  const CommentScreen({
    Key? key,
    required this.itemId,
    required this.itemType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // controller.getComments(itemId, itemType);
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppText('Comments'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => AppNavigator.pop(),
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
              child: GetBuilder<CommentController>(builder: (commentCtrl) {
                return FutureBuilder<List<Comment>>(
                    future: commentCtrl.getComments(itemId, itemType),
                    builder: (context, snapshot) {
                      List<Comment> commentsData = snapshot.data ?? [];
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, i) {
                            Comment commentData = commentsData[i];
                            return snapshot.hasData
                                ? GetBuilder<AuthController>(
                                    builder: (authCtrl) {
                                    return FutureBuilder<AuthModel>(
                                        future: authCtrl.fetchInfoUserById(
                                            commentData.userId),
                                        builder: (context, snapshot) {
                                          return snapshot.hasData
                                              ? CommentWidget(
                                                  itemId: itemId,
                                                  itemType: itemType,
                                                  commentData: commentData,
                                                  userData: snapshot.data!,
                                                )
                                              : Container();
                                        });
                                  })
                                : const CustomShimmerLike();
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
                          controller: controller.commentController,
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<CommentController>(builder: (commentCtrl) {
                      return IconButton(
                        onPressed: () {
                          if (keyForm.currentState!.validate()) {
                            commentCtrl.addComment(
                              itemId,
                              itemType,
                              commentCtrl.commentController.text,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      );
                    }),
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
