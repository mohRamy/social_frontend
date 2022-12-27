import 'package:get/get.dart';
import '../../../data/models/user_model.dart';

import '../../../../config/routes/app_pages.dart';
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
    return Column(
      children: [
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GetBuilder<SearchCtrl>(
              builder: (cont) => GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.PROFILE,
                    arguments: user,
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //image
                    Container(
                      width: Dimensions.height20 * 3,
                      height: Dimensions.height20 * 3,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            user.photo,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BigText(
                            text: user.name,
                            color: Colors.black54,
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(height: Dimensions.height10 - 5),
                          Text(
                            user.email,
                            style: TextStyle(fontSize: Dimensions.height15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(height: Dimensions.height15),
      ],
    );
  }
}
