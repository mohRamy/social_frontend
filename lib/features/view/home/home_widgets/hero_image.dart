import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class HeroImage extends StatelessWidget {
  final String post;
  const HeroImage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              imageUrl: post,
            ),
          ),
        ),
      ),
    );
  }
}
