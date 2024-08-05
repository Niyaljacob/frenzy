
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:frenzy/utils/api_urls/api_urls.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  static var client = http.Client();
  //Fetch loggedIn user posts
  static Future fetchUserPosts({String? userId}) async {
    try {
      final loggineduserId = await getUserId();
      if (kDebugMode) {
        print(loggineduserId);
      }
      var response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId'));
      if (kDebugMode) {
        print(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$loggineduserId');
      }
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      
    }
  }
}