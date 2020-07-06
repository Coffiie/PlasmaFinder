import 'dart:async';
import 'dart:io';

import 'package:donate_plasma/models/donor.dart';
import 'package:donate_plasma/models/patient.dart';
import 'package:donate_plasma/service/donor_service.dart';
import 'package:donate_plasma/service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_info/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationProvider extends ChangeNotifier {
  String deviceUuid;
  bool patientAlreadyRegistered;
  bool donorAlreadyRegistered;
  String bloodGroup;
  bool donorActiveness;
  String city;

  Future<void> updateDonor({String name, String phoneNumber, String bloodGroup, String deviceUuid, String city, bool isAvailable})async{
    Donor donor = Donor();

    donor.name = name;
    donor.phoneNumber = phoneNumber;
    donor.bloodGroup = bloodGroup;
    donor.deviceUuid = deviceUuid;
    donor.city = city;
    donor.isAvailable = isAvailable;

    DonorService().updateDonor(donor);
  }

  Future<Donor> getDonor()async{
    await getDeviceUuid();
    DocumentSnapshot docSnap = await Firestore.instance.collection("donor").document(deviceUuid).get();
    Donor donor = Donor();
    donor.isAvailable = docSnap.data['isAvailable'];
    donorActiveness = docSnap.data['isAvailable'];
    donor.bloodGroup = docSnap.data['bloodGroup'];
    donor.city = docSnap.data['city'];
    donor.name = docSnap.data['fullName'];
    donor.phoneNumber = docSnap.data['phoneNumber'];
    return donor;
  }

  Future<void> updatePatient({String fullName, String bloodGroup, String city,bool isRecovered})async{
    Patient patient = Patient();
    patient.bloodGroup = bloodGroup;
    patient.fullName = fullName;
    patient.city = city;
    patient.deviceUuid = deviceUuid;
    patient.isRecovered = isRecovered;

    PatientService().updatePatient(patient);

  }

  Future<Patient> getPatient() async{
    await getDeviceUuid();
    DocumentSnapshot docSnap = await Firestore.instance.collection("patient").document(deviceUuid).get();
    Patient patient = Patient();
    patient.bloodGroup = docSnap.data['bloodGroup'];
    patient.city = docSnap.data['city'];
    patient.fullName = docSnap.data['fullName'];
    patient.isRecovered = docSnap.data['isRecovered'];
    return patient;
  }

  Future<void> setDonorAvailability(bool value) async{
    donorActiveness = value;
    notifyListeners();
    await Firestore.instance.collection("donor").document(deviceUuid).setData({
      'isAvailable': value,
    },merge: true);
  }

  void setBloodGroup(String item){
    bloodGroup = item;
    notifyListeners();
  }

  Future<void> getDeviceUuid() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceUuid = androidInfo.androidId;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceUuid = iosInfo.identifierForVendor;
    }
  }

  Future<bool> isAlreadyRegistered() async {
    await getDeviceUuid();
    patientAlreadyRegistered = await isPatientAlreadyRegistered();
    donorAlreadyRegistered = await isDonorAlreadyRegistered();
    if (patientAlreadyRegistered || donorAlreadyRegistered) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isPatientAlreadyRegistered() async {
    var instance = Firestore.instance;

    var document =
        await instance.collection("patient").document(deviceUuid).get();
    if (document.data == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isDonorAlreadyRegistered() async {
    var instance = Firestore.instance;

    var document =
        await instance.collection("donor").document(deviceUuid).get();
    if (document.data == null) {
      return false;
    } else {
      return true;
    }
  }

  List<DocumentSnapshot> fetchDonors(
      String bloodType, List<DocumentSnapshot> documents) {
    List<DocumentSnapshot> list = List<DocumentSnapshot>();
    if (bloodType == "A+") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "A+") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "A-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O+") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }
    if (bloodType == "O+") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "O+") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }
    if (bloodType == "B+") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "B+") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "B-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O+") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }
    if (bloodType == "AB+") {
      return documents;
    }

    if (bloodType == "A-") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "A-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }

    if (bloodType == "O-") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }

    if (bloodType == "B-") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "B-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }

    if (bloodType == "AB-") {
      for (var item in documents) {
        if (item.data['bloodGroup'] == "AB-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "B-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "A-") {
          list.add(item);
        } else if (item.data['bloodGroup'] == "O-") {
          list.add(item);
        }
      }
    }
    return list;
  }

  Future<List<Donor>> matchBloodGroup(
       List<DocumentSnapshot> doc,String selectedCity) async {

         await getBloodGroupAndCity();
         
    List<DocumentSnapshot> documents = fetchDonors(bloodGroup, doc);

    List<Donor> donors = List<Donor>();
    for (int i = 0; i < documents.length; i++) {
      Donor donor = Donor();
      donor.isAvailable = documents[i].data['isAvailable'];

      if (donor.isAvailable && selectedCity == documents[i].data['city']) {
        donor.bloodGroup = documents[i].data['bloodGroup'];
        donor.name = documents[i].data['fullName'];
        donor.phoneNumber = documents[i].data['phoneNumber'];
        donor.city = documents[i].data['city'];
        donors.add(donor);
      }
    }

    

    return donors;
  }


  Future<void> getBloodGroupAndCity() async{

    DocumentSnapshot docSnap = await Firestore.instance.collection("patient").document(deviceUuid).get();
    bloodGroup = docSnap.data['bloodGroup'];
    city = docSnap.data['city'];
  }

  

  void setCity(String value){
    city = value;
    notifyListeners();
  }
}
