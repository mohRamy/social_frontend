import 'package:get/get.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../../core/widgets/widgets.dart';

import '../../../../core/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/components/profile_avatar.dart';
import '../controller/search_controller.dart';

class SearchedProduct extends GetView<SearchController> {
  final Auth user;
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
              child: GetBuilder<SearchController>(
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
