import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzy/firebase_options.dart';
import 'package:frenzy/utils/themes.dart';
import 'package:frenzy/views/bloc/forgot_password_bloc/bloc/forgotpassword_bloc.dart';
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

