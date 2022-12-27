import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../components/components.dart';

void stateHandle({
  required http.Response res,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
    Components.showCustomSnackBar(jsonDecode(res.body)['msg']);
    break;
    case 500:
    Components.showCustomSnackBar(jsonDecode(res.body)['error']);
    break;
    default:
    Components.showCustomSnackBar(title: 'successfull',jsonDecode(res.body)['error']);
  }
}

// void httpErrorHandleGet({
//   required Response res,
//   required VoidCallback onSuccess,
// }) {
//   switch (res.statusCode) {
//     case 200:
//       onSuccess();
//       break;
//     case 400:
//     //Components.showSnackBar(context, jsonDecode(res.body)['msg']);
//     Get.snackbar('msg', jsonDecode(res.body)['msg']);
//     break;
//     case 500:
//     //Components.showSnackBar(context, jsonDecode(res.body)['error']);
//     Get.snackbar('error', jsonDecode(res.body)['error']);
//     break;
//     default:
//     //Components.showSnackBar(context, res.body);
//     Get.snackbar('successfull', res.body);
//   }
// }

