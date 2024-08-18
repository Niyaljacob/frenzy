

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:frenzy/model/common_model/post_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
//google login
Future<UserCredential?>siginWithGoogle()async{
  try{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken
    );
    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    if(kDebugMode){
      // print(userCredential.user?.email);
    }
    log(userCredential.toString());
    return userCredential;
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}

//fire base logout
final GoogleSignIn _googleSignIn = GoogleSignIn();
Future<void> googleSignOut() async {
  await _googleSignIn.signOut();
  log("User signed out");
}


String formatDate(String inputDate) {
  try {
    // Debug print to check the input date
    print('Input date: $inputDate');
    
    // Define the input format
    DateFormat inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'");
    // Define the output format
    DateFormat outputFormat = DateFormat('dd MMM yyyy');

    // Parse the input date string
    DateTime dateTime = inputFormat.parseUtc(inputDate);
    DateTime now = DateTime.now().toUtc();

    // Calculate the difference
    Duration difference = now.difference(dateTime);

    // Check if the date is within one week
    if (difference.inDays < 7) {
      // Check if the date is today
      if (difference.inDays == 0) {
        if (difference.inHours > 0) {
          return '${difference.inHours} hours ago';
        } else if (difference.inMinutes > 0) {
          return '${difference.inMinutes} minutes ago';
        } else {
          return 'just now';
        }
      } else {
        return '${difference.inDays} days ago';
      }
    } else {
      return outputFormat.format(dateTime);
    }
  } catch (e) {
    // Print the error for debugging
    print('Error parsing date: $e');
    return 'Invalid date';
  }
}

List<Post> parsePosts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}
