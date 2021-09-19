import 'package:flutter/material.dart';
import 'package:practial_task/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    "https://previews.123rf.com/images/alurk/alurk2001/alurk200100249/136981581-lots-of-little-stars-on-blue-background-.jpg",
    "https://peerbits-wpengine.netdna-ssl.com/wp-content/uploads/2019/05/design-trends-in-mobile-applications-main.jpg",
    "https://previews.123rf.com/images/charmboyz/charmboyz1408/charmboyz140800256/31092504-antique-bronze-texture.jpg",
    "https://previews.123rf.com/images/charmboyz/charmboyz1412/charmboyz141200060/34964853-bronze-scratch-texture.jpg",
    "https://previews.123rf.com/images/yuryvialitchanka/yuryvialitchanka2001/yuryvialitchanka200100161/139024047-mountain-landscape-at-sunset-time-with-the-rays-of-the-sun-.jpg",
    "https://previews.123rf.com/images/nicholashan/nicholashan1406/nicholashan140600364/29397084-beautiful-sakura-garden-in-wuling-farm-taiwan-for-adv-or-others-purpose-use.jpg",
    "https://previews.123rf.com/images/nicholashan/nicholashan1312/nicholashan131200286/24496114-nice-view-in-the-high-mountain-for-adv-or-others-purpose-use.jpg",
  ];

  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  removeImage(index) {
    setState(() {
      images.removeAt(index);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Practical Task"), actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('_email');
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => LoginPage()));
              },
              child: Center(child: Text("Logout")),
            )),
      ]),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: images.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Please Confirm"),
                            content: Text("Are you want to delete"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("No")),
                              ElevatedButton(
                                  onPressed: () {
                                    removeImage(index);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text("Yes")),
                            ],
                          ));
                },
                child: Card(
                    child: Image.network(
                  images[index],
                  fit: BoxFit.cover,
                )),
                // onLongPress: showAlertDialog(context),
                // child: Card(

                //   child: Image.network(images[index]),
              );
            },
          )),
    );
  }
}
