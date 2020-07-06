import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_plasma/models/donor.dart';

class DonorService {
  Future<void> updateDonor(Donor donor)async{
    await Firestore.instance.collection("donor").document(donor.deviceUuid).setData({
      'fullName':donor.name,
      'bloodGroup':donor.bloodGroup,
      'isAvailable':donor.isAvailable,
      'phoneNumber':donor.phoneNumber,
      'city':donor.city,
    },merge:true);
  }

  Future<void> addDonor(
      {String name,
      String phoneNumber,
      String deviceUuid,
      String bloodGroup,
      String city,
      bool isAvailable}) async {
    Donor donor = Donor(
      city: city,
        name: name,
        phoneNumber: phoneNumber,
        deviceUuid: deviceUuid,
        bloodGroup: bloodGroup,
        isAvailable: isAvailable);
    var instance = Firestore.instance;
    await instance.collection("donor").document(deviceUuid).setData({
      'fullName': donor.name,
      'phoneNumber': donor.phoneNumber,
      'bloodGroup': donor.bloodGroup,
      'isAvailable': donor.isAvailable,
      'city':donor.city,
    });
  }

  
   
  }

