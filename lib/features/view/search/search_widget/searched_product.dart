import 'package:get/get.dart';
import 'package:social_app/core/widgets/widgets.dart';
import 'package:social_app/features/view/home/home_widgets/profile_avatar.dart';
import '../../../data/models/user_model.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/big_text.dart';
import 'package:flutter/material.dart';

import '../search_ctrl/search_ctrl.dart';

class SearchedProduct extends GetView<SearchCtrl> {
  final UserModel user;
  const SearchedProduct({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        children: [
          MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GetBuilder<SearchCtrl>(
                builder: (cont) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    ProfileAvatar(
                      imageUrl: user.photo,
                      sizeImage: 50,
                    ),
                    SizedBox(width: Dimensions.width15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextCustom(text: user.name),
                          SizedBox(height: Dimensions.height10 - 5),
                          TextCustom(text: user.email),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(height: Dimensions.height15),
        ],
      ),
    );
  }
}
