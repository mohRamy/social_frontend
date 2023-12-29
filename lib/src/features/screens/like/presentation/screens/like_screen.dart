import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../resources/local/user_local.dart';
import '../controllers/like_controller.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../routes/app_pages.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../../taps/home/presentation/components/shimmer_like.dart';

class LikeScreen extends GetView<LikeController> {
  final List<String> usersId;
  LikeScreen({
    Key? key,
    required this.usersId,
  }) : super(key: key);

  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(usersId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppText('Likes'),
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
        key: _keyForm,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<AuthModel>>(
                  future: controller.getUsersInfo(usersId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return !snapshot.hasData
                          ? const CustomShimmerLike()
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                AuthModel userData = snapshot.data![i];

                                return InkWell(
                                  onTap: () {
                                    userData.id != UserLocal().getUserId()
                                        ? AppNavigator.push(
                                            AppRoutes.anotherProfile,
                                            arguments: {
                                              "user-id": userData.id,
                                            },
                                          )
                                        : AppNavigator.push(
                                            AppRoutes.profile,
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
                    }
                    return const CustomShimmerLike();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
