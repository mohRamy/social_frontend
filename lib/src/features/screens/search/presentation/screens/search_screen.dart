import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../resources/local/user_local.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../components/searched_product.dart';
import '../controllers/search_controller.dart';

class SearchScreen extends GetView<SearchControlle> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                margin: EdgeInsets.all(Dimensions.size10),
                padding: EdgeInsets.only(left: Dimensions.size10),
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0)),
                child: TextField(
                  onChanged: (val) {
                    controller.changeSearchStatus(val);
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "search_users".tr,
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[700],
                      ),
                      suffixIcon: Icon(
                        Icons.search_rounded,
                        color: colorPrimary,
                      )),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => controller.users.isEmpty
                  ? Container()
                  : MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: Expanded(
                        child: ListView(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.users.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.users[index].id !=
                                            UserLocal().getUserId()
                                        ? AppNavigator.push(
                                            AppRoutes.anotherProfile,
                                            arguments: {
                                              "user-id":
                                                  controller.users[index].id,
                                            },
                                          )
                                        : AppNavigator.push(
                                            AppRoutes.profile,
                                          );
                                  },
                                  child: SearchedProduct(
                                    user: controller.users[index],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
