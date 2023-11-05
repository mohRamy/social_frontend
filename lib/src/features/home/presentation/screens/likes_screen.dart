import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';
import '../../../../core/widgets/app_text.dart';
import '../components/shimmer_like.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../routes/app_pages.dart';
import '../controller/home_controller.dart';

class LikesScreen extends GetView<HomeController> {
  final List<String> usersId;
  LikesScreen({
    Key? key,
    required this.usersId,
  }) : super(key: key);

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppText('Likes'),
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
        key: _keyForm,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<AuthModel>>(
                  future: controller.likesUser(usersId),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CustomShimmerLike()
                        : ListView.builder(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              AuthModel userData = snapshot.data![i];
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

                              return InkWell(
                                onTap: () {
                                  AppNavigator.push(
                                    AppRoutes.profileById,
                                    arguments: {
                                      "userId": userData.id,
                                    },
                                  );
                                },
                                child: Padding(
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
                                              NetworkImage(userData.photo),
                                        ),
                                        const SizedBox(width: 10.0),

                                        TextCustom(
                                          text: userData.name,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        // add dots to show this is a longer text
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
