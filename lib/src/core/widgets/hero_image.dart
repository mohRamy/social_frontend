import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../routes/app_pages.dart';


class HeroImage extends StatelessWidget {
  final String image;
  const HeroImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            AppNavigator.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          child: Hero(
            tag: 'jj',
            child: CachedNetworkImage(
              placeholder: (context, url) => const Text('loading...'),
              imageUrl: image,
            ),
          ),
        ),
      ),
    );
  }
}
