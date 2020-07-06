import 'package:donate_plasma/project_theme.dart';
import 'package:donate_plasma/provider/application_provider.dart';
import 'package:donate_plasma/service/donor_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonorRegisterationScreen extends StatefulWidget {
  @override
  _DonorRegisterationScreenState createState() =>
      _DonorRegisterationScreenState();
}

class _DonorRegisterationScreenState extends State<DonorRegisterationScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
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
  String _selectedCity = "Abbottabad";
  String _selectedBloodGroup = "A+";
  @override
  Widget build(BuildContext context) {
    _cities.sort();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectTheme.donorButton,
        title: Text("Donor Registeration"),
      ),
      body: SingleChildScrollView(
        child: buildFormLayout(),
      ),
    );
  }

  Widget buildFormLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _nameController,
            style: TextStyle(fontSize: 18),
            maxLength: 20,
            decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 20), labelText: "Full Name"),
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
                child: DropdownButton(
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
                      setState(() {
                        _selectedBloodGroup = item;
                      });
                    }),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: _phoneController,
            style: TextStyle(fontSize: 18),
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixText: "+92 ",
                helperText:
                    "Your phone number is revealed only when a patient decides to call you",
                helperMaxLines: 2,
                labelStyle: TextStyle(fontSize: 20),
                labelText: "Phone Number"),
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
                child: DropdownButton<String>(
                    value: _selectedCity,
                    items: _cities.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text("$value",style: TextStyle(fontSize:20),));
                    }).toList(),
                    onChanged: (item) {
                      print(item);
                      setState(() {
                        _selectedCity = item;
                      });
                    }),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RaisedButton(
            color: ProjectTheme.donorButton,
            onPressed: _isLoading
                ? () {}
                : () async {
                    if (_nameController.text.length > 0) {
                      if (_phoneController.text.length == 10) {
                        setState(() {
                          _isLoading = true;
                        });
                        var applicationProvider =
                            Provider.of<ApplicationProvider>(context,
                                listen: false);
                        await applicationProvider.getDeviceUuid();

                        bool isDonorRegistered = await applicationProvider
                            .isDonorAlreadyRegistered();

                        if (!isDonorRegistered) {
                          String name = _nameController.text;
                          String phoneNumber = _phoneController.text;
                          String deviceUuid = applicationProvider.deviceUuid;
                          bool isAvailable = true;
                          String bloodGroup = _selectedBloodGroup;
                          String city = _selectedCity;

                          await DonorService().addDonor(
                              name: name,
                              city: city,
                              phoneNumber: phoneNumber,
                              deviceUuid: deviceUuid,
                              isAvailable: isAvailable,
                              bloodGroup: bloodGroup);

                          
                          Navigator.pushReplacementNamed(
                              context, "/donorSettingScreen");
                        } else {
                          print('Donor is already registered');
                        }
                      } else {
                        print(
                            'Please enter your phone number in correct format');
                        Fluttertoast.showToast(
                            msg:
                                "Please enter your phone number in correct format",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    } else {
                      print('Please enter full name');
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
                    "Get enlisted as a Donor",
                    style: TextStyle(
                        fontSize: 18, color: ProjectTheme.textColorOverButton),
                  ),
          ),
        ),
      ],
    );
  }
}
