import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../domain/entities/comment.dart';
import '../components/comment_widget.dart';

import '../../../../core/widgets/widgets.dart';
import '../controller/home_controller.dart';

class PostCommentsScreen extends StatefulWidget {
  const PostCommentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  final _keyForm = GlobalKey<FormState>();
  HomeController homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
          text: 'Comments',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: .8,
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
        ),
      ),
      body: Form(
        key: _keyForm,
        child: Column(
          children: [
            Expanded(
              child: homeCtrl.postCommentList.isEmpty
                  ? Container()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemCount: homeCtrl.postCommentList.length,
                      itemBuilder: (context, i) {
                        Comment commentData = homeCtrl.postCommentList[i];
                        String timeAgoCustom(DateTime d) {
                          Duration diff = DateTime.now().difference(d);
                          if (diff.inDays > 365) {
                            return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
                          }
                          if (diff.inDays > 30) {
                            return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
                          }
                          if (diff.inDays > 7) {
                            return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
                          }
                          if (diff.inDays > 0) {
                            return DateFormat.E().add_jm().format(d);
                          }
                          if (diff.inHours > 0) {
                            return "Today ${DateFormat('jm').format(d)}";
                          }
                          if (diff.inMinutes > 0) {
                            return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
                          }
                          return "just now";
                        }

                        return FutureBuilder<Auth>(
                            future: Get.find<AuthController>()
                                .getUserData(commentData.userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Auth userData = snapshot.data!;
                                return CommentWidget(
                                  type: "post",
                                  commentData: commentData,
                                  userData: userData,
                                  uid: Get.arguments,
                                );
                              }
                              return const CustomShimmer();
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
                        if (_keyForm.currentState!.validate()) {
                          homeCtrl.postComment(
                            Get.arguments,
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
