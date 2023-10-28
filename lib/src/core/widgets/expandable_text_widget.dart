import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/app_colors.dart';
import 'app_text.dart';


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
  double textHeight = Get.height / 3.63;

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
            ? AppText(
                firstHalf,
                type: TextType.small,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hiddenText ? ('$firstHalf...') : (firstHalf + secondHalf),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: fCL,
                          height: 1.8,
                        ),
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
                hiddenText ? 'Show more' : 'Show less',
                style:
                    Theme.of(context).textTheme.bodyLarge!.copyWith(color: colorPrimary),
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
