import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frenzy/model/user_model.dart';
import 'package:frenzy/utils/api_urls/api_urls.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
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


  static Future<Response?>userLogin(String email, String password)async{
    try{
      var user ={
        'email':email,
        'password':password
      };
      var response=await client.post(
        Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.login),
        body: jsonEncode(user),
        headers: {
          "Content-Type":'application/json'
        }
      );
      debugPrint(response.statusCode.toString());
      if(kDebugMode){
        print(user);
      }
      debugPrint(response.body);
      final responseBody=jsonDecode(response.body);
      if(response.statusCode==200){
        await setUserLoggedin(
          token:responseBody ['user']['token'], 
         userrole: responseBody['user']['role'],
          userid: responseBody['user']['_id'],
          userEmail: responseBody['user']['email'],
          userName: responseBody['user']['userName'],
          userprofile: responseBody['user']['profilePic'],
        );
        return response;
      }else{
        return response;
      }
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }


static Future<Response?>resetPasswordOtp(String email)async{
  try{
    Response? response=await client.get(Uri.parse(
      '${ApiEndpoints.baseUrl+ApiEndpoints.forgotPassword}$email'
    ));
    if(kDebugMode){
      print(response.body);
    }
    return response;
  }catch(e){
    return null;
  }
}

static Future<Response?>verifyOtpPasswordReset(
  String email, String otp
)async{
try{
  var response = await client.get(Uri.parse('${ApiEndpoints.baseUrl+ApiEndpoints.verifyOtpReset}$email&otp=$otp'));
  return response;
}catch(e){
  return null;
}
}

static Future<Response?>passwordUpdate(String email, String password)async{
  try{
    var user= {'email':email,
    'password':password};
    var response=await client.patch(Uri.parse(ApiEndpoints.baseUrl+ApiEndpoints.updatePassword),
    body: jsonEncode(user),
    headers: {"Content-Type": 'application/json'}
    );
    if (kDebugMode) {
        print(response.body);
      }
      return response;
  }catch(e){
    return null;
  }
}
}