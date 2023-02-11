import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_app/controller/user_ctrl.dart';
import 'package:social_app/core/utils/dimensions.dart';
import 'package:social_app/core/widgets/expandable_text_widget.dart';
import 'package:social_app/features/data/models/comment_model.dart';
import 'package:social_app/features/data/models/user_model.dart';
import 'package:social_app/features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'package:social_app/features/view/home/home_ctrl/home_ctrl.dart';
import 'package:social_app/features/view/home/home_widgets/comment_widget.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../core/widgets/widgets.dart';

class PostCommentsScreen extends StatefulWidget {
  const PostCommentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCommentsScreen> createState() => _PostCommentsScreenState();
}

class _PostCommentsScreenState extends State<PostCommentsScreen> {
  final _keyForm = GlobalKey<FormState>();

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
      body: GetBuilder<HomeCtrl>(builder: (homeCtrl) {
        return homeCtrl.isLoading
            ? const CustomShimmer()
            : Form(
                key: _keyForm,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemCount: homeCtrl.postComments.length,
                          itemBuilder: (context, i) {
                            CommentModel commentData = homeCtrl.postComments[i];
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
                            
                            return FutureBuilder<UserModel>(
                                future: Get.find<AuthCtrl>()
                                    .fetchUserData(commentData.userId),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    UserModel userData = snapshot.data!;
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
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(18.0))),
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
                                  controller: Get.find<HomeCtrl>().postCommentC,
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.only(left: 10.0),
                                      hintText: 'Enter your commnet',
                                      hintStyle: GoogleFonts.roboto(
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                            GetBuilder<HomeCtrl>(builder: (homeCtrl) {
                              return IconButton(
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    homeCtrl.postComment(
                                      Get.arguments,
                                      Get.find<HomeCtrl>().postCommentC.text,
                                    );
                                    Get.find<HomeCtrl>().postCommentC.text = '';
                                  }
                                },
                                icon: const Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
