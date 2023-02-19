import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_app/features/auth/domain/entities/auth.dart';
import 'package:social_app/features/auth/presentation/controller/auth_controller.dart';
import '../../../data/models/comment_model.dart';
import '../home_ctrl/home_ctrl.dart';
import '../home_widgets/comment_widget.dart';

import '../../../../core/widgets/widgets.dart';

class StoryCommentsScreen extends StatefulWidget {
  final String uid;

  const StoryCommentsScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<StoryCommentsScreen> createState() => _StoryCommentsScreenState();
}

class _StoryCommentsScreenState extends State<StoryCommentsScreen> {
  final _keyForm = GlobalKey<FormState>();
  bool isLike = false;

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
              child: GetBuilder<HomeCtrl>(builder: (homeCtrl) {
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: homeCtrl.storyComments.length,
                    itemBuilder: (context, i) {
                      CommentMode commentData = homeCtrl.storyComments[i];
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
                                type: "story",
                                commentData: commentData,
                                userData: userData,
                                uid: widget.uid,
                              );
                            }
                            return const CustomShimmer();
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
                          controller: Get.find<HomeCtrl>().storyCommentC,
                          style: GoogleFonts.roboto(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 10.0),
                              hintText: 'Enter your commnet',
                              hintStyle:
                                  GoogleFonts.roboto(color: Colors.white)),
                        ),
                      ),
                    ),
                    GetBuilder<HomeCtrl>(builder: (homeCtrl) {
                      return IconButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            homeCtrl.storyComment(
                              widget.uid,
                              homeCtrl.storyCommentC.text,
                            );
                            homeCtrl.storyCommentC.text = '';
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
      ),
    );
  }
}
