import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frenzy/model/user_model.dart';
import 'package:frenzy/utils/api_urls/api_urls.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


class AuthenticationRepository{
  static var client = http.Client();
  Future<Response?>sentingOtp(UserModel user)async{
    var data ={
      "userName": user.userName,
      "email": user.emailId,
      "password": user.password,
      "phone": user.phoneNumber
    };
    var jsonData = jsonEncode(data);
    try{
      final response = await client.post(
        Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.signUp),
        body: jsonData,
        headers: {
          "Content-Type":"application/json",
        }
      );
      return response;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?>verifyOtp(String email, String otp)async{
    var data ={
      'email':email, 
      'otp':otp
      };
      try{
        var response = await client.post(
          Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.verifyOtp),
          body: jsonEncode(data),
          headers: {
            "Content-type": "application/json",
          }
        );
        debugPrint(response.body);
        return response;
      }catch(e){
        debugPrint(e.toString());
        return null;
      }
  }
}