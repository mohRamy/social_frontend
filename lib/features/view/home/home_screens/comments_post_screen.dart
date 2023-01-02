import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:social_app/features/data/models/comment_model.dart';
import 'package:social_app/features/view/home/home_ctrl/home_ctrl.dart';

import '../../../../core/widgets/widgets.dart';

class CommentsPostScreen extends GetView<HomeCtrl> {
  final String uidPost;

  CommentsPostScreen({
    Key? key,
    required this.uidPost,
  }) : super(key: key);

  
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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black87)),
      ),
      body: Form(
        key: _keyForm,
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<HomeCtrl>(builder: (homeCtrl) {
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: homeCtrl.comments.length,
                    itemBuilder: (context, i) {
                      CommentModel commentData = homeCtrl.comments[i];
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

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            right: 5.0,
                            bottom: 5.0,
                          ),
                          // color: Colors.green,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                backgroundImage:
                                    NetworkImage(commentData.userData.photo),
                              ),
                              const SizedBox(width: 10.0),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextCustom(
                                      text: commentData.userData.name,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    Text(commentData.comment),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: const Icon(
                                              Icons.favorite_border_rounded,
                                              size: 19),
                                        ),
                                        TextCustom(
                                          text: timeAgoCustom(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              commentData.time,
                                            ),
                                          ),
                                          fontSize: 13,
                                        ),
                                      ],
                                    )
                                    // add dots to show this is a longer text
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
                          controller: Get.find<HomeCtrl>().commentC,
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
                            
                            homeCtrl.postComment(
                              uidPost,
                              homeCtrl.commentC.text,
                            );
                            homeCtrl.commentC.text = '';
                            
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
