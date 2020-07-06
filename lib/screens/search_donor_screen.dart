import 'package:donate_plasma/models/donor.dart';
import 'package:donate_plasma/project_theme.dart';
import 'package:donate_plasma/provider/application_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SearchDonorScreen extends StatefulWidget {
  String city;

  SearchDonorScreen(this.city);
  @override
  _SearchDonorScreenState createState() => _SearchDonorScreenState();
}

class _SearchDonorScreenState extends State<SearchDonorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    
    var applicationProvider =
        Provider.of<ApplicationProvider>(context, listen: false);
    
    _cities.sort();
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: false,
            bottom: PreferredSize(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "City: ",
                        style: TextStyle(
                            fontSize: 20, color: ProjectTheme.headingTextColor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Consumer<ApplicationProvider>(
                            builder: (context, provider, _) {
                          return SearchableDropdown.single(
                           
                            value: provider.city,
                            hint: Container(
                                padding: EdgeInsets.all(10),
                                                        child: Text("${provider.city}",style: TextStyle(
                                fontSize: 20,
                                color: ProjectTheme.textColorOverButton
                              ),),
                            ),
                            
                            underline: Container(height: 1.0,decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ProjectTheme.textColorOverButton
                                )
                              )
                            ),),
                                  iconEnabledColor: ProjectTheme.textColorOverButton,
                                  style: TextStyle(fontSize:20,color:ProjectTheme.textColorOverButton),
                                  
                                  items: _cities.map((String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          "$value",
                                          style: TextStyle(fontSize:20),
                                        ));
                                  }).toList(),
                                  displayClearIcon: false,
                                  onChanged: (item) {

                                    print(item);
                                    provider.setCity(item);
                                   
                                  });
                        }),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size(double.infinity, 50)),
            backgroundColor: ProjectTheme.patientButton,
            title: Text("Current Donors"),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/patientSettingScreen");
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.settings,
                        size: 30,
                      )))
            ],
          ),
          StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("donor").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                   return SliverList(delegate: SliverChildBuilderDelegate((context,i)=>buildShimmer(index: i),childCount: 10),) ;
                  } else {
                    return 
                                          Consumer<ApplicationProvider>(

                                        builder:(context,provider,_){return FutureBuilder<List<Donor>>(
                          future: applicationProvider
                              .matchBloodGroup(snapshot.data.documents,provider.city),
                          builder: (context, snapshot) {
                            
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.data.length == 0) {
                                return SliverList(delegate: SliverChildListDelegate(
                                                                  [Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Text(
                                      "Sorry, there is currently no donor registered that is compatible with your blood type, try again later",
                                      style: TextStyle(
                                          color: ProjectTheme.patientButton,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),]
                                )); 
                              } else {
                                return SliverList(delegate: SliverChildBuilderDelegate(
                                  
                                    (context, index) {
                                      return Slidable(
                                        actionPane: SlidableStrechActionPane(),
                                        actionExtentRatio: 0.25,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Card(
                                            color: ProjectTheme.patientButton,
                                            elevation: 4,
                                            margin: EdgeInsets.symmetric(vertical: 10),
                                            child: ListTile(
                                              trailing: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: ProjectTheme
                                                            .textColorOverButton),
                                                    child: Text(
                                                      "${snapshot.data[index].bloodGroup}",
                                                      style: TextStyle(
                                                          color: ProjectTheme
                                                              .patientButton,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 5, vertical: 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(2),
                                                        color: ProjectTheme
                                                            .textColorOverButton),
                                                    child: Text(
                                                      "${snapshot.data[index].city}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: ProjectTheme
                                                              .patientButton),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    ProjectTheme.textColorOverButton,
                                                child: Text(
                                                  "${snapshot.data[index].name[0]}${snapshot.data[index].name[1]}",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                foregroundColor:
                                                    ProjectTheme.patientButton,
                                              ),
                                              title: Text(
                                                "${snapshot.data[index].name}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: ProjectTheme
                                                        .textColorOverButton),
                                              ),
                                              subtitle: Text(
                                                'Swipe right to call this person (standard charges will be applied)',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: ProjectTheme
                                                        .textColorOverButton),
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 10),
                                            child: Card(
                                              elevation: 4,
                                              margin:
                                                  EdgeInsets.symmetric(vertical: 10),
                                              child: IconSlideAction(
                                                caption: 'Call',
                                                color: Colors.green,
                                                icon: Icons.phone,
                                                onTap: () async {
                                                  var url =
                                                      'tel:+92${snapshot.data[index].phoneNumber}';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },childCount: snapshot.data.length,
                                    ));
                              }
                              
                            }
                            else
                            {
                              return SliverList(delegate: SliverChildBuilderDelegate((context,index)=>buildShimmer(index: index),childCount: 10),) ;
                            }
                          },
                        ); } 
                      );
                  }
                }),
          
        ],
      ),
    );
    
  }

  Widget buildShimmer({int index}) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      enabled: true,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
       
     
    );
  }
}
