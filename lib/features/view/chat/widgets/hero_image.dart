import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';


class ChatHeroImage extends StatelessWidget {
  final String message;
  const ChatHeroImage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Hero(
            tag: 'jj',
            child: CachedNetworkImage(
              placeholder: (context, url) => const Text('loading...'),
              imageUrl: message,
            ),
          ),
        ),
      ),
    );
  }
}
