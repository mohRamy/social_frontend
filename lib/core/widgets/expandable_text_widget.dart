import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';
import 'small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 6.63;

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
            ? SmallText(
                color: context.textTheme.bodyText1!.color,
                size: Dimensions.font16,
                text: firstHalf,
              )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    height: 1.8,
                    color: context.textTheme.bodyText1!.color,
                    size: Dimensions.font16,
                    text: hiddenText
                        ? ('$firstHalf...')
                        : (firstHalf + secondHalf),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        SmallText(
                          text: hiddenText ? 'Show more' : 'Show less',
                          color: context.textTheme.bodyText1!.color,
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: context.textTheme.bodyText1!.color,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
