import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MainScreen.dart';
import 'onBoardingScreen.dart';
import 'presentation/my_matches/view/MyMathesPage.dart';

late SharedPreferences preferences;
final remoteConfig = FirebaseRemoteConfig.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await isCallStars();
  preferences = await SharedPreferences.getInstance();
  bool isOnBoarding = preferences.getBool('onBoarding') ?? false;

  runApp(MyApp(isOnBoarding: isOnBoarding));
}

class MyApp extends StatelessWidget {
  final bool isOnBoarding;

  const MyApp({super.key, required this.isOnBoarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isOnBoarding ? MyHomePage() : const OnBoardingScreen();
          } else {
            return Scaffold(
              backgroundColor: const Color(0xFF053F7B),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .15,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: 100,
                      child: Lottie.asset(
                        'assets/images/anim.json',
                        height: 200,
                        width: 200,
                        repeat: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
