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

  
}