import 'package:donate_plasma/models/patient.dart';
import 'package:donate_plasma/project_theme.dart';
import 'package:donate_plasma/provider/application_provider.dart';
import 'package:donate_plasma/service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientSettingScreen extends StatefulWidget {
  @override
  _PatientSettingScreenState createState() => _PatientSettingScreenState();
}

class _PatientSettingScreenState extends State<PatientSettingScreen> {
  bool _isLoading = false;
  TextEditingController _nameController = TextEditingController();

  List<String> _bloodGroups = [
    "A+",
    "A-",
    "O+",
    "O-",
    "B+",
    "B-",
    "AB+",
    "AB-"
  ];

  
  List<String> _cities = [
    "Quetta",
    "Khuzdar",
    "Chaman",
    "Turbat",
    "Sibi",
    "Lasbela",
    "Zhob",
    "Gwadar",
    "Nasirabad",
    "Jaffarabad",
    "Peshawar",
    "Mardan",
    "Mingora",
    "Kohat",
    "Abbottabad",
    "Bannu",
    "Swabi",
    "Dera Ismail Khan",
    "Charsadda",
    "Nowshera",
    "Lahore",
    "Faisalabad",
    "Rawalpindi",
    "Gujranwala",
    "Multan",
    "Sargodha",
    "Bahawalpur",
    "Sialkot",
    "Sheikhupura",
    "Gujrat",
    "Jhang",
    "Sahiwal",
    "Karachi",
    "Hyderabad",
    "Sukkur",
    "Larkana",
    "Nawabshah",
    "Mirpur Khas",
    "Jacobabad",
    "Shikarpur",
    "Khairpur",
    "Dadu",
    "Kotli",
    "Muzaffarabad",
    "Rawalakot",
    "New Mirpur City",
    "Bhimber",
    "Bagh",
    "Pallandri",
    "Athmuqam",
    "Hattian Bala",
    "Haveli",
    "Islamabad",
    "Gilgit",
    "Skardu",
    "Chilas",
    "Khaplu",
    "Juglot",
    "Gahkuch",
    "Aliabad",
    "Bunji"
  ];

  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectTheme.patientButton,
        title: Text("Patient Settings"),
      ),
      body: buildFormLayout(),
    );
  }


  Widget buildFormLayout() {
    var applicationProvider = Provider.of<ApplicationProvider>(context,listen: false);
    String _selectedCity = applicationProvider.city;
    String _selectedBloodGroup = applicationProvider.bloodGroup;
    _cities.sort();
    return FutureBuilder<Patient>(
        future: applicationProvider.getPatient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _nameController.text = snapshot.data.fullName;
            applicationProvider.bloodGroup = snapshot.data.bloodGroup;
            applicationProvider.city = snapshot.data.city;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      maxLength: 20,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 20),
                          labelText: "Full Name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Blood Group: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Consumer<ApplicationProvider>(
                              builder: (context, provider, _) {
                            return DropdownButton(
                                value: _selectedBloodGroup,
                                items: [
                                  DropdownMenuItem(
                                    value: _bloodGroups[0],
                                    child: Text(
                                      "${_bloodGroups[0]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[1],
                                    child: Text(
                                      "${_bloodGroups[1]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[2],
                                    child: Text(
                                      "${_bloodGroups[2]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[3],
                                    child: Text(
                                      "${_bloodGroups[3]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[4],
                                    child: Text(
                                      "${_bloodGroups[4]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[5],
                                    child: Text(
                                      "${_bloodGroups[5]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[6],
                                    child: Text(
                                      "${_bloodGroups[6]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: _bloodGroups[7],
                                    child: Text(
                                      "${_bloodGroups[7]}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                ],
                                onChanged: (item) {
                                  provider.setBloodGroup(item);
                                  _selectedBloodGroup = item;
                                });
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "City: ",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Consumer<ApplicationProvider>(

                                                      builder:(context,provider,_){return DropdownButton<String>(
                                value: provider.city,
                                items: _cities.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        "$value",
                                        style: TextStyle(fontSize: 20),
                                      ));
                                }).toList(),
                                onChanged: (item) {
                                  provider.setCity(item);
                                 _selectedCity = item;
                                  
                                });} 
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: ProjectTheme.patientButton,
                      onPressed: _isLoading
                          ? () {}
                          : () async {
                              //get device uuid

                              if (_nameController.text.length > 0) {
                                setState(() {
                                  _isLoading = true;
                                });
                                var applicationProvider =
                                    Provider.of<ApplicationProvider>(context,
                                        listen: false);
                                String fullName = _nameController.text;
                                String bloodGroup = _selectedBloodGroup;
                                
                                String city = _selectedCity;
                                applicationProvider.setCity(city);
                                applicationProvider.setBloodGroup(bloodGroup);
                                await applicationProvider.updatePatient(
                                    fullName: fullName,
                                    bloodGroup: bloodGroup,
                                    city: city,
                                    isRecovered: false);
                                //navigate to donor search screen
                                 Fluttertoast.showToast(
                                    msg: "Profile updated",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(context, "/searchDonorScreen/:${applicationProvider.city}");
                              } else {
                                print("Please enter your full name");

                                Fluttertoast.showToast(
                                    msg: "Please enter your full name",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                      child: _isLoading
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    ProjectTheme.textColorOverButton),
                              ),
                            )
                          : Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ProjectTheme.textColorOverButton),
                            ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(ProjectTheme.patientButton),
                ),
              ),
            );
          }
        });
  }
}
