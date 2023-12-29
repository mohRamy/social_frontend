import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/app_colors.dart';
import 'app_text.dart';

class ExpandablePostWidget extends StatefulWidget {
  final String text;
  const ExpandablePostWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandablePostWidget> createState() => _ExpandablePostWidgetState();
}

class _ExpandablePostWidgetState extends State<ExpandablePostWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Get.height / 5.63;

  @override
  void initState() {
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(
                firstHalf,
                // maxLines: 7,
                style: Theme.of(context).textTheme.titleMedium,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    hiddenText ? ('$firstHalf...') : (firstHalf + secondHalf),
                    type: TextType.medium,
                    maxLines: 40,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          hiddenText ? 'show_more'.tr : 'show_less'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: colorPrimary),
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: colorPrimary,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
