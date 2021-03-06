import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
    print(data.toString());
    return data;
  }

  final _urlInputController = TextEditingController();

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
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _urlInputController,
                        style: TextStyle(
                          fontSize: 20,
                          // fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Paste URL",
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
                    onPressed: () async {
                      print(_urlInputController.text);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => MyConnectDialogBox(),
                      );
                      var mydata =
                          await makeRequest("${_urlInputController.text}");
                      print(mydata['url'].toString());
                      if (mydata != null && mydata['hashid'] != null) {
                        Navigator.pop(context);
                        showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: SelectableText(
                                          'https://rel.ink/${mydata['hashid']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFF4e54c8),
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text:
                                                  'https://rel.ink/${mydata['hashid']}',
                                            ),
                                          );
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                MyCopiedDialogBox(),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.content_copy,
                                                color: Color(0xFF4e54c8),
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Copy",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        textColor: Color(0xFF4e54c8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Share.share('https://rel.ink/${mydata['hashid']}');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.share,
                                                color: Color(0xFF4e54c8),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Share",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        textColor: Color(0xFF4e54c8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (mydata != null && mydata['hashid'] == null) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => MyErrorDialogBox(),
                        );
                      } else {
                        Navigator.pop(context);
                        print("Null");
                      }
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

class MyConnectDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
          ),
        ),
        child: ListTile(
          leading: CircularProgressIndicator(),
          title: Text(
            "\tConverting...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

class MyErrorDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.red,
          ),
          title: Text(
            "ERROR",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          subtitle: Text("Enter a valid URL"),
        ),
      ),
    );
  }
}

class MyCopiedDialogBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(10.0),
            topRight: const Radius.circular(10.0),
            bottomLeft: const Radius.circular(10.0),
            bottomRight: const Radius.circular(10.0),
          ),
        ),
        child: ListTile(
          leading: Icon(
            Icons.check,
            size: 50,
            color: Colors.green,
          ),
          title: Text(
            "Copied",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
