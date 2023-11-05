  import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';

Future<String> cloudinaryPuplic(String msg) async {
    int random = Random().nextInt(1000);

    final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

    CloudinaryResponse res = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        msg,
        folder: "$msg $random",
      ),
    );
    return res.secureUrl;
  }