import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/sizer_custom/sizer.dart';
import 'app_colors.dart';

class AppDecoration {
  final BoxDecoration decoration;
  AppDecoration({required this.decoration});
  factory AppDecoration.displayFile(context, File message) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              message,
            ),
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.sp),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              message,
            ),
          ),
        ),
      );
    }
  }

  factory AppDecoration.displayImageVideo(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
      );
    }
  }

  factory AppDecoration.productFavoriteCart(context, radius) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: colorDarkBranch,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(1, 1),
              color: colorPrimary.withOpacity(0.3),
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.textfeild(
    context,
    radius,
  ) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: fCD,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCL,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: const Offset(0, 2),
              color: mCH,
            ),
          ],
        ),
      );
    }
  }

  factory AppDecoration.bottomNavigationBar(context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return AppDecoration(
        decoration: BoxDecoration(
          color: fCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
          ),
        ),
      );
    } else {
      return AppDecoration(
        decoration: BoxDecoration(
          color: mCD,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.sp),
            topRight: Radius.circular(45.sp),
          ),
        ),
      );
    }
  }
}
