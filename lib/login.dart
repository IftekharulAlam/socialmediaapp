// ignore_for_file: sort_child_properties_last, use_build_context_synchronously, unused_field, unused_local_variable, prefer_final_fields

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:socialmediaapp/alertdialog/errorDialog.dart';
import 'package:socialmediaapp/homepage.dart';
import 'package:socialmediaapp/socialmedia.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isLoading = false; //bool variable created
  bool? saveInformationCheckBox = false;
  String userID = "None";
  Future login(
      String name, String password, bool saveInformationCheckBox) async {
    String finalUrl = "$mydeviceIP/login";
    var url = Uri.parse(finalUrl);
    var response =
        await http.post(url, body: {"name": name, "password": password});
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data[0]["result"] == "Wrong") {
        errordialog(context);
      } else {
        setState(() {
          _isLoading = false;
        });
        if (saveInformationCheckBox) {
          userID = name;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userName: name,
              ),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                userName: name,
              ),
            ),
          );
        }
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Social Media',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.greenAccent,
                      activeColor: Colors.red,
                      value: saveInformationCheckBox,
                      onChanged: (bool? value) {
                        setState(() {
                          saveInformationCheckBox = value;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      child: const Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              !_isLoading
                  ? Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (name.text.isEmpty ||
                              password.text.isEmpty ||
                              name.text.isEmpty && password.text.isEmpty) {
                            errordialog(context);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(
                                  userName: 'User',
                                ),
                              ),
                            );
                            // login(name.text, password.text,
                            //     saveInformationCheckBox!);
                          }
                        },
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
