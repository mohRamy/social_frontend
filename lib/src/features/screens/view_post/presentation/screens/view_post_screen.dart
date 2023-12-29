
import 'package:flutter/material.dart';

import '../../../../taps/home/data/models/post_model.dart';
import '../../../../../core/widgets/post_widget.dart';

class ViewPostScreen extends StatelessWidget {
  final PostModel post;
  const ViewPostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PostWidget(postData: post, index: 0),
    );
  }
}