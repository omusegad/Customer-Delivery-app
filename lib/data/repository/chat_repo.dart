import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_restaurant/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_restaurant/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_restaurant/data/model/response/base/api_response.dart';
import 'package:flutter_restaurant/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ChatRepo {
  final DioClient dioClient;
  ChatRepo({@required this.dioClient});

  Future<ApiResponse> getChatList() async {
    try {
      final response = await dioClient.get(AppConstants.MESSAGE_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> sendMessage(String message, File file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SEND_MESSAGE_URI}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
    }
    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      'message': message
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
}