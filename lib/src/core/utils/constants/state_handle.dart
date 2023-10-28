import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../public/components.dart';

void stateHandle({
  required http.Response res,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Components.showSnackBar(jsonDecode(res.body)['msg']);
      break;
    case 500:
      Components.showSnackBar(jsonDecode(res.body)['error']);
      break;
    default:
      Components.showSnackBar(
          title: 'successfull', jsonDecode(res.body)['error']);
  }
}

// void stateErrorHandle({
//   required http.Response res,
//   required VoidCallback onSuccess,
// }) {
//   switch (res.statusCode) {
//     case 200:
//       onSuccess();
//     break;
//     case 400:
//     throw ServerException(messageError: jsonDecode(res.body)['msg']);
//     case 500:
//     throw ServerException(messageError: jsonDecode(res.body)['error']);
//     default:
//     throw ServerException(messageError: jsonDecode(res.body)['error']);
//   }
// }
