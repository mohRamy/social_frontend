import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/core/error/exceptions.dart';

import '../app_component.dart';

void stateHandle({
  required http.Response res,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      AppComponent.showCustomSnackBar(jsonDecode(res.body)['msg']);
      break;
    case 500:
      AppComponent.showCustomSnackBar(jsonDecode(res.body)['error']);
      break;
    default:
      AppComponent.showCustomSnackBar(
          title: 'successfull', jsonDecode(res.body)['error']);
  }
}

void stateErrorHandle({
  required http.Response res,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      throw ServerException(messageError: jsonDecode(res.body)['msg']);
    case 500:
      throw ServerException(messageError: jsonDecode(res.body)['error']);
    default:
      throw ServerException(messageError: "Error");
  }
}
