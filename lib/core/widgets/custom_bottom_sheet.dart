
import 'package:flutter/material.dart';
import 'package:social_app/core/utils/dimensions.dart';

import '../utils/app_strings.dart';
import '../utils/app_colors.dart';


bottomSheet(BuildContext context, Function()? pickImageCamera, Function()? pickImageGallery,) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.height20,
              vertical: Dimensions.height10 + 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'personal photo',
                  style: TextStyle(fontSize: Dimensions.font20),
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: pickImageCamera,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Dimensions.height10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                        const Text('Camera'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width30,
                    ),
                    GestureDetector(
                      onTap: pickImageGallery,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(Dimensions.height10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Icon(
                              Icons.photo,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Gallery"),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



