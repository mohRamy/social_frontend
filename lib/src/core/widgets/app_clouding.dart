import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';

Future<String> cloudinaryPublic(String imgPath) async {
  int random = Random().nextInt(1000);

  final cloudinary = CloudinaryPublic('dvn9z2jmy', 'lkma7rx1');
  // final cloudinary = CloudinaryPublic('drqugmsbb', 'ijhnbtko');

  CloudinaryResponse res = await cloudinary.uploadFile(
    CloudinaryFile.fromFile(
      imgPath,
      folder: "$imgPath$random",
    ),
  );

  return res.secureUrl;
}

  // final url = Uri.parse('http://api.cloudinary.com/v1_1/dvn9z2jmy/upload');

  //   final request = http.MultipartRequest('POST', url)
  //   ..fields['upload_preset'] = 'lkma7rx1'
  //   ..files.add(await http.MultipartFile.fromPath('file', imgPath));

  //   final response = await request.send();

  //   if (response.statusCode == 200) {
  //     final responseData = await response.stream.toBytes();
  //     final responseString = String.fromCharCodes(responseData);
  //     final jsonMap = jsonDecode(responseString);

  //     final url = jsonMap['url'];
  //     image = url;
  //   }

  

// final Dio _dio = Dio();

// // Cloudinary configuration
// final String cloudinaryApiKey = '836372844187662';
// final String cloudinaryApiSecret = 'G2RxCcvsy_HtAXQEp00wUUQif1s';
// final String cloudinaryCloudName = 'drqugmsbb';

// const url = 'https://api.cloudinary.com/v1_1/drqugmsbb/image/upload';

// Future<void> uploadImageToCloudinary(String imagePath) async {
//   FormData formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(
//         imagePath,
//       ),
//       "upload_preset": "ijhnbtko",
//       "cloud_name": "drqugmsbb",
//     });
//     try {
//       Response response = await _dio.post(url, data: formData);

//       var data = jsonDecode(response.toString());
//       print(data['secure_url']);

//       print('ccccccccccccccccccccccccccc');

//       print(data['secure_url']);

      // setState(() {
      //   imageUrl = data['secure_url'];
      // });
    // } catch (e) {
    //   print(e);
    // }
  // try {
  //   FormData formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(imagePath),
  //     'upload_preset': 'ijhnbtko',
  //   });

  //   // CLOUDINARY_URL=cloudinary://836372844187662:G2RxCcvsy_HtAXQEp00wUUQif1s@drqugmsbb

  //   Response response = await _dio.post(
  //     'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/image/upload',
  //     data: formData,
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'multipart/form-data',
  //         'Authorization': 'Basic ' + base64Encode(utf8.encode('$cloudinaryApiKey:$cloudinaryApiSecret')),
  //       },
  //     ),
  //   );

  //   // Handle the Cloudinary response here
  //   print('ccccccccccccccccccccccccc');
  //   print(response.data);
  // } catch (error) {
  //   print('Error uploading image to Cloudinary: $error');
  // }
// }