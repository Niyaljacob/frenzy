import 'dart:convert';
import 'dart:io';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:frenzy/utils/api_urls/api_urls.dart';
import 'package:frenzy/utils/functions/set_user_loggedin.dart';
 import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostRepository{
  static var client =http.Client();

  static Future<Response?>addPost(String description, String image)async{
    try{
      final imageUrl = await PostRepository.uploadImage(image);
      final userid = await getUserId();
      final token = await getUsertoken();
      final post={
        'imageUrl': imageUrl,
        'description': description,
        'userId': userid
      };
      var response = await client.post(
          Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.addpostUrl}'),
          body: jsonEncode(post),
          headers: {
            "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
          });
          debugPrint(response.statusCode.toString());
      return response;
    }catch(e){
      return null;
    }
  }


  static Future uploadImage(imagePath)async{
    String filePath = imagePath;
    File file = File(filePath);
    try{
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dkfo7pehx/image/upload');
      final request = http.MultipartRequest('POST',url)
      ..fields['upload_preset']='jixlomft'
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
      final response = await request.send();
      debugPrint(response.statusCode.toString());
      if(response.statusCode==200){
        final responseData = await response.stream.toBytes();
        final reponseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(reponseString);
        log(jsonMap['url']);
        return jsonMap['url'];
      }
    }catch(e){
      log(e.toString());
    }
  }

  static Future<Response?>deletePost(String postId)async{
    try{
      final token=await getUsertoken();
      var responce = await client.delete(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.deletePost}/$postId'),
        headers: {'Authorization': 'Bearer $token'}
      );
      debugPrint(responce.statusCode.toString());
      debugPrint(responce.body);
      return responce;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<Response?>fetchPosts()async{
    try{
      final token=await getUsertoken();
      debugPrint('Token is $token');
      var responce = await client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getallPost}'),
      headers: {'Authorization': 'Bearer $token'});
      debugPrint(responce.statusCode.toString());
      debugPrint(responce.body);
      return responce;
    }catch(e){
      log(e.toString());
      return null;
    }
  }


  static Future<Response?>editPost(
    {
      required String description,
      required image,
      required String postId,
      required imageUrl
    }
  )async{
dynamic cloudinaryimageUrl;
try{
  if(image!=''){
    cloudinaryimageUrl=await PostRepository.uploadImage(image);
  }
  final token = await getUsertoken();
  final post={
    'imageUrl': image != '' ? cloudinaryimageUrl : imageUrl,
        'description': description,
  };
  var responce = await client.put(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.updatePost}/$postId'),
  body: jsonEncode(post),
  headers: {
    "Content-Type": 'application/json',
            'Authorization': 'Bearer $token'
  }
  );
  debugPrint(responce.statusCode.toString());
      debugPrint(responce.body);
      return responce;
}catch(e){
  log(e.toString());
      return null;
}
  }



  static Future getFollowersPost({required int page})async{
    try{
      final token = await getUsertoken();
      var responce = await client.get(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.allFollowingsPost}?page=$page&pageSize=5'),
        headers: {'Authorization': 'Bearer $token'}
      );
      return responce;
    }catch(e){
      log(e.toString());
    }
  }
  

  static Future savePost({required String postId})async{
    try{
      final token=await getUsertoken();
      var response = await client.post(
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.savePost}/$postId'),
        headers:  {'Authorization': 'Bearer $token'}
      );
      return response;
    }catch(e){
      log(e.toString());
    }
  }

  static Future removeSavedPost({required String postId})async{
    try{
      final token = await getUsertoken();
      var responce=await client.delete(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.removeSavedPost}'),
      headers: {'Authorization': 'Bearer $token'});
      return responce;
    }catch(e){
      log(e.toString());
    }
  }

  static Future fetchSavedPosts()async{
    try{
      final token = await getUsertoken();
      var responce = await client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.fetchSavedPost}'),
      headers: {'Authorization': 'Bearer $token'});
      return responce;
    }catch(e){
      log(e.toString());
    }
  }

  static Future fetchExplorePosts()async{
    try{
      final token=await getUsertoken();
      var responce= await client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.explorePosts}'),
     headers: {'Authorization': 'Bearer $token'});
     return responce;
    }catch(e){
      log(e.toString());
    }
  }

  static Future commentPost({
    required String postId,
      required String userName,
      required String content})async{
        try{
          final userId = await getUserId();
      final token = await getUsertoken();
      final comment = {
        'userId': userId,
        'userName': userName,
        'postId': postId,
        'content': content
      };
      var responce = await client.post(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.commentPost}'),
      body: jsonEncode(comment),
      headers: {
        'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
      }

      );
      debugPrint(responce.statusCode.toString());
      debugPrint(responce.body);
      return responce;
        }catch(e){
          log(e.toString());
        }
      }


      static Future getAllComments({required String postId})async{
        try{
          final token = await getUsertoken();
          var responce = await client.get(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.getAllComments}'),
          headers: {'Authorization': 'Bearer $token'});
          debugPrint(responce.statusCode.toString());
          return responce;
        }catch(e){
          log(e.toString());
        }
      }


      static Future deleteComment({required String commentId})async{
        try{
          final token = await getUsertoken();
          var response = await client.delete(
            Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.deleteComments}/$commentId'),
            headers: {'Authorization': 'Bearer $token'}
          );
          debugPrint(response.statusCode.toString());
          debugPrint(response.body);
          return response;
        }catch(e){
          log(e.toString());

        }
      }

      static Future unlikePost({required String postId})async{
        try{
          final token = await getUsertoken();
          var response = await client.patch(Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.unlikePost}/$postId'),
          headers: {'Authorization': 'Bearer $token'});
          return response;
        }catch(e){
          log(e.toString());
        }
      }
}