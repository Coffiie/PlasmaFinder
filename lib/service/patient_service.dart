import 'package:donate_plasma/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  Future<void> registerPatient(
      {String fullName,
      String bloodGroup,
      String deviceUuid,
      String city}) async {
    Patient patient = Patient(
        fullName: fullName,
        bloodGroup: bloodGroup,
        deviceUuid: deviceUuid,
        isRecovered: false,
        city: city);

    var instance = Firestore.instance;
    await instance.collection("patient").document(patient.deviceUuid).setData({
      'fullName': patient.fullName,
      'bloodGroup': patient.bloodGroup,
      'deviceUuid': patient.deviceUuid,
      'isRecovered': patient.isRecovered,
      'city': patient.city
    });
  }

  Future<void> updatePatient(Patient patient) async {
    await Firestore.instance
        .collection("patient")
        .document(patient.deviceUuid)
        .setData(
            {'fullName': patient.fullName, 'bloodGroup': patient.bloodGroup,'isRecovered':patient.isRecovered,'city':patient.city},
            merge: true);
  }
}
