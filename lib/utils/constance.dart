import 'package:flutter/material.dart';


// colors
const whiteColor = Colors.white;
const primary = Color(0xFF0C3452);
const black = Colors.black;
const grey = Colors.grey;
const red =Colors.red;
const green = Colors.green;
const greyNew=Color.fromARGB(255, 233, 232, 232);

//image

const logodark = 'assets/splash1.png';
const logolight = 'assets/splash2.png';
const login = 'assets/login_logo.png';
const google = "assets/Googleimg.png";
const singupdark = "assets/Frenzyblack.png";
const singuplight = "assets/Frenzy.png";
const imagepicker = "assets/image picker.jpg";
const sadForgot= 'assets/otp_sad.png';
const happyForgot = 'assets/otp_happy.png';
const post1 = "assets/post1.webp";
const profile1 ="assets/images.jpeg";

//border radius 

BorderRadius radius10 = BorderRadius.circular(10);
final BorderRadius radius20 = BorderRadius.circular(50);


//heights

const kheight = SizedBox(
  height: 10,
);
const kheight20 = SizedBox(
  height: 20,
);
const kheight15 = SizedBox(
  height: 15,
);

const kheight30 = SizedBox(
  height: 30,
);

const kheight40 = SizedBox(
  height: 40,
);

const kheight50 = SizedBox(
  height: 50,
);
const kheight80 = SizedBox(
  height: 80,
);
const kheight100 = SizedBox(
  height: 100,
);

//texts

const loginText = Text('Login',style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700));
const forgot = Text("Forgot password?",style: TextStyle(color: primary, fontWeight: FontWeight.bold),);
const forgotpassword = Text('Forgot Password ?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: primary),);
const forgotpassword1 =Text('      Enter the email address\n associated with your account.',style: TextStyle(fontSize: 20,color: primary),);
const forgotpassword2 = Text('we will email you a link to reset\n                your passowrd.',style: TextStyle(fontSize: 16,color: grey),);
const forgotpassword3 =  Text("Enter the Verification code we\n    just sent you on your email \n                    address",style: TextStyle(fontSize: 20,color: primary),);
const singupText= Text(""" "Discover moments captured by your friends\n               through photos and videos. \n          Sign up now to stay connected!" """,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),);
const registerotp =   Text("We have sent the verification code to your email address.",style: TextStyle(fontSize: 16),);



//auth key sharedpreference
const authKey = 'UserLoggedIn';

//token key sharedpreference
const tokenKey = 'userToken';

//userid key sharedpreference
const userIdKey = 'userId';

//userRole key sharedpreference
const userRolekey = 'userRole';

//userEmail key sharedpreference
const userEmailkey = 'userEmail';

//userName key sharedpreference
const userNamekey = 'userName';

//userProfilepic key sharedpreference
const userProfilePickey = 'userProfilePic';