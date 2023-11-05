import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../../../home/presentation/components/profile_avatar.dart';

class SearchedProduct extends GetView<SearchController> {
  final AuthModel user;
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
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    ProfileAvatar(
                      imageUrl: user.photo,
                      sizeImage: 50,
                    ),
                    SizedBox(width: Dimensions.size15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextCustom(text: user.name),
                          SizedBox(height: Dimensions.size5),
                          TextCustom(text: user.email),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          SizedBox(height: Dimensions.size15),
        ],
      ),
    );
  }
}
