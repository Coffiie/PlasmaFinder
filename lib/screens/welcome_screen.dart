import 'package:donate_plasma/project_theme.dart';
import 'package:donate_plasma/provider/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        buildBackgroundGradient(),
        buildFrontLayout(context),
      ],
    ));
  }

  Widget buildBackgroundGradient() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            ProjectTheme.backgroundColor1,
            ProjectTheme.backgroundColor2
          ])),
    );
  }

  Widget buildFrontLayout(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context,
                        type: ProgressDialogType.Normal, isDismissible: false);
     pr.style(message: "Please wait");
    var applicationProvider =
        Provider.of<ApplicationProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Text(
                  "Welcome, select your role",
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      color: ProjectTheme.headingTextColor,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  color: ProjectTheme.patientButton,
                  onPressed: () async {
                    
                   
                    await pr.show();
                    await applicationProvider.getDeviceUuid();
                    bool patientAlready =
                        await applicationProvider.isPatientAlreadyRegistered();

                    
                    print(patientAlready);
                    if (patientAlready) {
                      await applicationProvider.getBloodGroupAndCity();
                      await pr.hide();
                      Navigator.pushNamed(context, "/searchDonorScreen/:${applicationProvider.city}");
                    } else {
                      await pr.hide();
                      Navigator.pushNamed(
                          context, "/patientRegisterationScreen");
                    }
                  },
                  child: Text(
                    "I'm a Patient",
                    style: TextStyle(color: ProjectTheme.textColorOverButton),
                  )),
              SizedBox(width: 20),
              RaisedButton(
                  color: ProjectTheme.donorButton,
                  onPressed: () async {
                    
                    await pr.show();
                    await applicationProvider.getDeviceUuid();
                    bool donorAlready =
                        await applicationProvider.isDonorAlreadyRegistered();
                    
                    print(donorAlready);
                    if (donorAlready) {
                      pr.hide();
                      Navigator.pushNamed(context, "/donorSettingScreen");
                    } else
                    {
                      pr.hide();
                      Navigator.pushNamed(context, "/donorRegisterationScreen");
                    }
                      
                  },
                  child: Text(
                    "I'm a Donor",
                    style: TextStyle(color: ProjectTheme.textColorOverButton),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
