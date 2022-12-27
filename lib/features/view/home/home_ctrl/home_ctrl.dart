import 'dart:convert';

import 'package:get/get.dart';
import '../home_repo/home_repo.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../../data/models/post_model.dart';
import 'package:http/http.dart' as http;

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeCtrl({
    required this.homeRepo,
  });

  List<PostModel> posts = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    fetchAllPosts();
    super.onInit();
  }

  void fetchAllPosts() async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.fetchAllPosts();

      stateHandle(
        res: res,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            posts.add(
              PostModel.fromMap(
                  jsonDecode(res.body)[i],
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  // void userDataById({
  //   required String userId,
  // }) async {
  //   try {
  //     user ==
  //         UserModel(
  //           id: "",
  //           name: "",
  //           email: "",
  //           bio: "",
  //           followers: [],
  //           following: [],
  //           photo: "",
  //           backgroundImage: "",
  //           phone: "",
  //           password: "",
  //           address: "",
  //           type: "",
  //           token: "",
  //         );
  //     http.Response res = await homeRepo.userDataById(userId);
  //     user ==
  //         UserModel.fromJson(
  //           jsonEncode(
  //             jsonDecode(res.body),
  //           ),
  //         );
  //   } catch (e) {
  //     Components.showCustomSnackBar(e.toString());
  //   }
  // }
}
