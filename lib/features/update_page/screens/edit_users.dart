import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../models/userdata_model.dart';
import '../../home_page/screens/view_user.dart';
import '../controller/edit_user_controller.dart';

class EditUser extends ConsumerStatefulWidget {
  const EditUser({
    super.key,
    required this.UserDataobj,
  });
  final UserData UserDataobj;

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends ConsumerState<EditUser> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _age = TextEditingController();

  void updateUser(
      {required UserData userData,
      required String name,
      required int age,
      required String phone}) {
    ref
        .read(editUserControllerProvider)
        .updateUser(userData: userData, name: name, age: age, phone: phone);
  }

  @override
  void initState() {
    super.initState();

    _name.text = widget.UserDataobj.name!;
    _phone.text = widget.UserDataobj.phone!;
    _age.text = widget.UserDataobj.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Update User",
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is empty';
                    }
                    return null;
                  },
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: "Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+(?:\.\d+)?$')),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is empty';
                    }
                    return null;
                  },
                  controller: _age,
                  decoration: InputDecoration(
                    hintText: "Age",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 3, right: 3, top: 10),
                child: IntlPhoneField(
                  controller: _phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextButton(
                  onPressed: () async {
                    int? n = int.tryParse(_age.text);
                    if (_name.text.isEmpty ||
                        _age.text.isEmpty ||
                        _phone.text.length != 10) {
                      final snackbar = SnackBar(
                        content: Text('Please fill in all fields'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } else {
                      try {
                        updateUser(
                            userData: widget.UserDataobj,
                            name: _name.text,
                            age: n!,
                            phone: _phone.text);
                        // updateUser(
                        //     userData: widget.UserDataobj,
                        //     name: _name.text,
                        //     age: n!,
                        //     phone: _phone.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewUser();
                            },
                          ),
                        );
                      } catch (error) {
                        print('Error updating user: $error');
                      }
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Edit user",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
