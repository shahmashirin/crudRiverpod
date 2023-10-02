import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../models/userdata_model.dart';
import '../controller/home_screen_controller.dart';
import 'view_user.dart';

class AddUser extends ConsumerStatefulWidget {
  const AddUser({super.key});

  @override
  ConsumerState<AddUser> createState() => _AdduserState();
}

class _AdduserState extends ConsumerState<AddUser> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _age = TextEditingController();

  createUser({required DocumentReference reference}) {
    UserData model = UserData(
        name: _name.text,
        phone: _phone.text,
        age: int.tryParse(_age.text),
        uid: reference.id,
        reference: reference,
        delete: false);

    ref.read(homeScreenControllerProvider.notifier).createuser(
        userData: model, context: context, ref: ref, reference: reference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return 'name is empty';
                  }
                  return null;
                },
                controller: _name,
                decoration: InputDecoration(
                    hintText: "name",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 3, right: 3),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+(?:\.\d+)?$')),
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty && value == null) {
                    return 'age is empty';
                  }
                  return null;
                },
                controller: _age,
                decoration: InputDecoration(
                    hintText: "age",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 3, right: 3, top: 10),
                child: IntlPhoneField(
                  controller: _phone,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Add User"),
                          content: Text("You want to create new user"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel")),
                            TextButton(
                                onPressed: () async {
                                  int? n = int.tryParse(_age.text);
                                  if (_name.text.isEmpty ||
                                      _age.text.isEmpty ||
                                      _phone.text.length != 10) {
                                    final snackbar = SnackBar(
                                      content:
                                          Text('Please fill in all fields'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackbar);
                                  } else {
                                    DocumentSnapshot doc =
                                        await FirebaseFirestore.instance
                                            .collection("settings")
                                            .doc("settings")
                                            .get();

                                    String id = "${doc['userId']}";
                                    doc.reference.update(
                                        {"userId": FieldValue.increment(1)});

                                    DocumentReference ref = FirebaseFirestore
                                        .instance
                                        .collection('list')
                                        .doc(id);
                                    createUser(reference: ref);
                                  }

                                  // .doc()
                                  // .set(a.tojson()).then((value) => value);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ViewUser();
                                    },
                                  ));
                                },
                                child: Text('Add'))
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    child: Center(
                        child: Text(
                      "Add user",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
