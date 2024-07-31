

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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