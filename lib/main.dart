import 'package:donate_plasma/provider/application_provider.dart';
import 'package:donate_plasma/router/FluroRouter.dart';
import 'package:donate_plasma/screens/donor_registeration_screen.dart';
import 'package:donate_plasma/screens/donor_setting_screen.dart';
import 'package:donate_plasma/screens/patient_registeration_screen.dart';
import 'package:donate_plasma/screens/search_donor_screen.dart';
import 'package:donate_plasma/screens/welcome_screen.dart';
import 'package:donate_plasma/service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  FluroRouter.defineRoutes();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ApplicationProvider>(
      create: (context) => ApplicationProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var applicationProvider = Provider.of<ApplicationProvider>(context,listen:false);
    return MaterialApp(
        onGenerateRoute: FluroRouter.router.generator,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        home: WelcomeScreen());
              
  }
}
