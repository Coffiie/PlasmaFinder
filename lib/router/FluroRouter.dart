import 'package:donate_plasma/screens/donor_registeration_screen.dart';
import 'package:donate_plasma/screens/donor_setting_screen.dart';
import 'package:donate_plasma/screens/patient_registeration_screen.dart';
import 'package:donate_plasma/screens/patient_setting_screen.dart';
import 'package:donate_plasma/screens/search_donor_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FluroRouter {
  static Router router = Router();

  static void defineRoutes() {
    router.define("/patientRegisterationScreen", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return PatientRegisterationScreen();
    }));

    router.define("/donorRegisterationScreen", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return DonorRegisterationScreen();
    }));

    router.define("/searchDonorScreen/:city",transitionType: TransitionType.inFromRight, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return SearchDonorScreen(params["city"][0]);
    }));

     router.define("/donorSettingScreen", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return DonorSettingScreen();
    }));

    router.define("/patientSettingScreen", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return PatientSettingScreen();
    }));

  }
}
