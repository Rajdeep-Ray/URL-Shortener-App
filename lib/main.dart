import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<dynamic> makeRequest(myurl) async {
    var data;
    String url = 'https://rel.ink/api/links/';
    var response = await http.post(
      Uri.encodeFull(url),
      body: {"url": "$myurl"},
    );
    setState(() {
      data = jsonDecode(response.body);
    });
    //print(data.toString());
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF34495E),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Image.asset('images/link-image.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "URL Shorty",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 22,
                          // fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter URL",
                          hintStyle: TextStyle(fontSize: 18),
                          icon: Icon(
                            Icons.link,
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    child: Text(
                      "Shorten",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () async{
                      var mydata = await makeRequest("https://news.ycombinator.com/");
                      print(mydata.toString());
                      if (mydata == null) {
                        print("This is NULL");
                      } else if (mydata != null) {
                        print("I have data");
                      }

                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) => MyDialogBox(
                      //     title: "Success",
                      //     description:
                      //         "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      //     buttonText: "Okay",
                      //   ),
                      // );
                    },
                    color: Colors.blueAccent,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyDialogBox extends StatelessWidget {
//   final String title, description, buttonText;

//   MyDialogBox({
//     @required this.title,
//     @required this.description,
//     @required this.buttonText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0.0,
//       backgroundColor: Colors.transparent,
//       child: _dialogContent(context),
//     );
//   }

//   _dialogContent(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           padding: EdgeInsets.only(
//             top: 82,
//             bottom: 16,
//             left: 16,
//             right: 16,
//           ),
//           margin: EdgeInsets.only(top: 66),
//           decoration: new BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10.0,
//                 offset: const Offset(0.0, 10.0),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // To make the card compact
//             children: <Widget>[
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 description,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16.0,
//                 ),
//               ),
//               SizedBox(height: 24.0),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // To close the dialog
//                   },
//                   child: Text(buttonText),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: 10,
//           right: 10,
//           child: CircleAvatar(
//             backgroundColor: Colors.green,
//             radius: 66,
//             child: Icon(Icons.check, size: 70, color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }
