import 'package:flutter/material.dart';
import '../../utils/sizer_custom/sizer.dart';

import '../../routes/app_pages.dart';
import '../../themes/app_colors.dart';
import '../widgets/app_text.dart';

class DialogConfirm extends StatefulWidget {
  final String title;
  final String subTitle;
  final Function handleConfirm;
  final double? height;

  const DialogConfirm({
    super.key,
    required this.handleConfirm,
    required this.subTitle,
    required this.title,
    this.height,
  });

  @override
  State<StatefulWidget> createState() => _DialogConfirmState();
}

class _DialogConfirmState extends State<DialogConfirm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.sp,
      height: widget.height ?? 130.sp,
      padding: EdgeInsets.only(
        top: Dimensions.size16,
        bottom: Dimensions.size10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.size15),
            child: AppText(
              widget.title,
            ),
          ),
          SizedBox(height: 6.sp),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.size15,
              vertical: 7.5.sp,
            ),
            child: Text(
              widget.subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 10.5.sp,
                color: fCL,
              ),
            ),
          ),
          SizedBox(height: 4.sp),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  AppNavigator.pop();
                },
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.size5,
                  ),
                  child: const AppText(
                    'Refuse',
                    type: TextType.small,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.pop();
                  widget.handleConfirm();
                },
                child: Container(
                  color: Colors.transparent,
                  // width: 300.sp,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5.sp),
                  child: Text(
                    'Agree',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: colorPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
