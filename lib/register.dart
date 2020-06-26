import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'main.dart';
import 'path.dart';
 
class RegisterPage extends StatefulWidget {
  RegisterPage() : super();
 
  final String title = "Upload Image Demo";
 
  @override
  RegisterPageState createState() => RegisterPageState();
}
 
class RegisterPageState extends State<RegisterPage> {
  //
  static final String uploadEndPoint =
      'http://digiblade.in/upload/upload.php';
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uding Image';
  String errMessag = 'Error Uding ';
   final nameController = TextEditingController();
  final passwordController = TextEditingController();
   final emailController = TextEditingController();
  final numberController = TextEditingController();
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
      showImage();
    });
    setStatus('');
  }
 
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
 
  startUpload() {
    
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessag);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    
    upload(fileName);
  }
 
  upload(String fileName) async{
    http.post('https://digiblade.in/upload/upload.php', body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      _signup();
    }).catchError((error) {
      setStatus(error);
    });
  }
  void _signup() async {
    
    if (nameController.text.length == 0) {
      _showDilog('Error', "Enter valid Name");
      return null;
    }
    if (emailController.text.length == 0) {
      _showDilog('Error', "Enter valid Email");
      return null;
    }
    if (passwordController.text.length == 0) {
      _showDilog('Error', "Enter valid Password ");
      return null;
    }
    if (numberController.text.length == 0) {
      _showDilog('Error', "Enter valid Number");
      return null;
    }
   
    
   
    var response = await http.post("$api/register", body: {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "mobile": numberController.text,
     

    });
    print(response.body);
    var datauser = json.decode(response.body);
    if (datauser.length == 0) {
      _showDilog('unautorized access', "Enter valid credential");
      return null;
    } else {
      if (datauser['flag'] == '1') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", emailController.text);
        pref.setString("number", numberController.text);
         Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

      }

    }
  }
   void _showDilog(String title, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ok"))
            ],
          );
        });
  }

   showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          print(base64Image);
          return ;
      }
      else{
        return;
      }
      }
    );
  }
 
  @override
  Widget build(BuildContext context) {

    const PrimaryColor = const Color(0xFF34a24b);
    return MaterialApp(
         theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Upload Image Demo"),
        ),
        body: SingleChildScrollView(
                  child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
          Container(
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Image.asset(
                          'assets/logo.png',
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
                          TextField(
                            controller: nameController,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                // hintText: 'EMAIL',
                                // hintStyle: ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                // hintText: 'EMAIL',
                                // hintStyle: ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText: 'PASSWORD ',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                            obscureText: true,
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            controller: numberController,
                            decoration: InputDecoration(
                                labelText: 'Contact Number ',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green))),
                          ),
                        
                          
                            OutlineButton(
                              onPressed: chooseImage,
                              child: Text('Choose Image'),
                            ),
                            
                            Text(
                              status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            ),
                         
                          SizedBox(height: 10.0),
                          SizedBox(height: 50.0),
                          Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: FlatButton(
                                  onPressed: () {
                                    startUpload();
                                  },
                                  child: Center(
                                    child: Text(
                                      'SIGNUP',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 20.0),
                          Container(
                            height: 40.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                  child: Text('Go Back',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
                                ),
                              ),
                            ),
                          ),
               
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}