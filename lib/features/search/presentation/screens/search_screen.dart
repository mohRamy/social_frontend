import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../../core/utils/dimensions.dart';

import '../components/searched_product.dart';
import '../controller/search_controller.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.users = [];
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        GetBuilder<SearchController>(builder: (searchCtrl) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              margin: EdgeInsets.all(Dimensions.height10),
              padding: EdgeInsets.only(left: Dimensions.height10),
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                onChanged: (val) {
                  searchCtrl.changeSearchStatus(val);
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Users ...",
                    hintStyle: TextStyle( 
                    //GoogleFonts.roboto(
                      fontSize: 17, 
                      color: Colors.grey[700],
                      ),
                    suffixIcon: Icon(Icons.search_rounded, color: AppColors.primary,)),
              ),
            ),
          );
        }),

        const SizedBox(height: 10.0),

        GetBuilder<SearchController>(
          builder: (searchCtrl) => searchCtrl.users.isEmpty
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
                          itemCount: searchCtrl.users.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.PROFILE,
                                  arguments: searchCtrl.users[index].id,
                                );
                              },
                              child: SearchedProduct(
                                user: searchCtrl.users[index],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),

        // const _GridPostSearch(),
      ])),
    );
  }
}

// class _GridPostSearch extends StatelessWidget {

//   const _GridPostSearch({Key? key, }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//     return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 2,
//           mainAxisSpacing: 2,
//           mainAxisExtent: 170
//         ),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: 9,
//         itemBuilder: (context, i) {

//           // final List<String> listImages =posts[i].images.split(',');

//           return GestureDetector(
//               onTap: () {},
//               // onLongPress: () => modalShowPost(context, post: posts[i]),
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration:const  BoxDecoration(
//                   // image: DecorationImage(
//                   //   fit: BoxFit.cover,
//                   //   image: NetworkImage(Environment.baseUrl + listImages.first)
//                   // )
//                 )
//               ),
//             );
//         }
//       );
//   }
// }