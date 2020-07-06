import 'package:donate_plasma/models/donor.dart';
import 'package:donate_plasma/project_theme.dart';
import 'package:donate_plasma/provider/application_provider.dart';
import 'package:donate_plasma/service/donor_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonorSettingScreen extends StatefulWidget {
  @override
  _DonorSettingScreenState createState() => _DonorSettingScreenState();
}

class _DonorSettingScreenState extends State<DonorSettingScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
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
    _cities.sort();
    var applicationProvider =
        Provider.of<ApplicationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Settings"),
        backgroundColor: ProjectTheme.donorButton,
      ),
      body: FutureBuilder<Donor>(
          future: applicationProvider.getDonor(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ProjectTheme.donorButton),
                  ),
                ),
              );
            } else {
              _nameController.text = snapshot.data.name;
              _phoneController.text = snapshot.data.phoneNumber;
              applicationProvider.bloodGroup = snapshot.data.bloodGroup;
              applicationProvider.city = snapshot.data.city;
              return SingleChildScrollView(
                              child: Column(
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
                  child: Consumer<ApplicationProvider>(

                                      builder:(context,provider,_){return DropdownButton(
                        value: provider.bloodGroup,
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
                        });} 
                  ),
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
                  child: Consumer<ApplicationProvider>(

                                      builder:(context,provider,_){return DropdownButton<String>(
                        value: provider.city,
                        items: _cities.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text("$value",style: TextStyle(fontSize:20),));
                        }).toList(),
                        onChanged: (item) {
                         provider.setCity(item);
                        });} 
                  ),
                ),
            ],
          ),
        ),
        
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(
                          "Beware of calls from unknown numbers, they may be looking for plasma!",
                          style: TextStyle(
                              color: Colors.red.shade500,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Show me in the Donor Search List",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Consumer<ApplicationProvider>(
                              builder: (context, provider, _) {
                            return Switch(
                              activeColor: ProjectTheme.donorButton,
                              value: provider.donorActiveness,
                              onChanged: (test) async {
                                await provider.setDonorAvailability(test);
                                if (test) {
                                  Fluttertoast.showToast(
                                      msg: "Added to the Donor Search List",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green.shade500,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Removed from the Donor Search List",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Consumer<ApplicationProvider>(
                            builder: (context, provider, _) {
                          if (provider.donorActiveness) {
                            return Text(
                              "At the moment, you're enlisted in the Donor Search List",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Container();
                          }
                        })),
                        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RaisedButton(
            color: ProjectTheme.donorButton,
            onPressed: 
                 () async {
                    if (_nameController.text.length > 0) {
                      if (_phoneController.text.length == 10) {
                        
                        var applicationProvider =
                            Provider.of<ApplicationProvider>(context,
                                listen: false);
                       

                        

                        
                          String name = _nameController.text;
                          String phoneNumber = _phoneController.text;
                          String deviceUuid = applicationProvider.deviceUuid;
                          bool isAvailable = applicationProvider.donorActiveness;
                          String bloodGroup = applicationProvider.bloodGroup;
                          String city = applicationProvider.city;

                          await applicationProvider.updateDonor(name:name,phoneNumber:phoneNumber,deviceUuid:deviceUuid,isAvailable:isAvailable,bloodGroup:bloodGroup,city:city);

                           Fluttertoast.showToast(
                            msg:
                                "Profile Updated",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                       
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
                     
                    });
                  },
            child:  Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 18, color: ProjectTheme.textColorOverButton),
                  ),
          ),
        ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
