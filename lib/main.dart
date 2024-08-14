import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/firebase_options.dart';
import 'package:frenzy/utils/themes.dart';
import 'package:frenzy/views/bloc/addpost/bloc/addpost_bloc.dart';
import 'package:frenzy/views/bloc/edit_user_profile/edit_user_profile_bloc.dart';
import 'package:frenzy/views/bloc/fetch_followers_bloc/fetch_followers_bloc.dart';
import 'package:frenzy/views/bloc/fetch_following_bloc/fetch_following_bloc.dart';
import 'package:frenzy/views/bloc/fetch_my_post/bloc/fetchmypost_bloc.dart';
import 'package:frenzy/views/bloc/fetch_saved_post/fetch_saved_posts_bloc.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_bloc.dart';
import 'package:frenzy/views/bloc/login_user_details_bloc/login_user_details_bloc.dart';
import 'package:frenzy/views/bloc/signin/bloc/signin_bloc.dart';
import 'package:frenzy/views/bloc/signup/otpverification_register/bloc/otp_verification_bloc.dart';
import 'package:frenzy/views/bloc/signup/signup_bloc/sign_up_bloc.dart';
import 'package:frenzy/views/pages/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>EditUserProfileBloc()),
        BlocProvider(create: (context)=>FetchSavedPostsBloc()),
        BlocProvider(create: (context)=>FetchFollowingBloc()),
        BlocProvider(create: (context)=>FetchFollowersBloc()),
        BlocProvider(create: (context)=>LoginUserDetailsBloc()),
        BlocProvider(create: (context)=>FetchmypostBloc()),
        BlocProvider(create: (context)=>AddpostBloc()),
        BlocProvider(create: (context)=>ForgotPasswordBloc()),
        BlocProvider(create: (context)=>SignUpBloc()),
        BlocProvider(create: (context)=>SigninBloc()),
        BlocProvider(create: (context)=>OtpVerificationBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightModeTheme,
        darkTheme: Themes.darkModeTheme,
      
        home: const SplashScreen(),
      ),
    );
  }
}

