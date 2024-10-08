
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:frenzy/repository/post_repo/post_repo.dart';
import 'package:frenzy/utils/api_urls/api_urls.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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


  static Future<Response?>fetchLoggedInUserDetails()async{
    try{
      final token = await getUsertoken();
      var response = await client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.logginedUser}'),
      headers: {'Authorization': 'Bearer $token'});
      return response;
    }catch(e){
      log(e.toString());
      return null;
    }
  }

  static Future<Response?>fetchSuggessionUser()async{
    try{
      final token = await getUsertoken();
      var responce = client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.suggessions}'),
      headers: {'Authorization': 'Bearer $token'});
      return responce;
    }catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future fetchFollowers() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getFollowers}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }


  static Future fetchFollowing() async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getFollowing}'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }


  //follow user
  static Future followUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      var response = client.post(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.followUser}/$followeesId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  //unfollow user
  static Future unfollowUser({required String followeesId}) async {
    try {
      final token = await getUsertoken();
      var response = client.put(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.unfollowUser}/$followeesId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  static Future editProfile(
      {required String image,
    required  String name,
     required String bio,
    required  String imageUrl,
    required  String bgImageUrl,
      required String bgImage}) async {
    try {
      dynamic cloudinaryimageUrl;
      dynamic cloudinarybgimageUrl;
      if (image != '') {
        cloudinaryimageUrl = await PostRepository.uploadImage(image);
      }
      if (bgImage != '') {
        cloudinarybgimageUrl = await PostRepository.uploadImage(bgImage);
      }
      final token = await getUsertoken();
      final details = {
        "name": name ,
        "bio": bio ,
        "image": image != '' ? cloudinaryimageUrl : imageUrl,
        "backGroundImage": bgImage != '' ? cloudinarybgimageUrl : bgImageUrl
      };
      var response = await client.put(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.editProfile}'),
          body: jsonEncode(details),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          });
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
    }
    // final image
  }


  static Future fetchUserPostsOther({required String userId}) async {
    try {
     
      
      var response = await client.get(Uri.parse(
          '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$userId'));
      if (kDebugMode) {
        print(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.getPostByUserId}/$userId');
      }
      // debugPrint(response.statusCode.toString());
      // debugPrint(response.body);
      return response;
    } catch (e) {
      log(e.toString());
      
    }
  }


    static Future getConnections({required String userId}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.getConnections}/$userId'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }



  static Future searchAllUsers({required String query}) async {
    try {
      final token = await getUsertoken();
      var response = await client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.searchAllUsers}$query'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }


  static Future getSingleUser({required String userid}) async {
    try {
      final token = await getUsertoken();
      var response = client.get(
          Uri.parse(
              '${ApiEndpoints.baseUrl}${ApiEndpoints.getSingleUser}/$userid'),
          headers: {'Authorization': 'Bearer $token'});
      return response;
    } catch (e) {
      log(e.toString());
    }
  }
}




