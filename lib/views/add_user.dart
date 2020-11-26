import 'package:corefactors/app_colors.dart';
import 'package:corefactors/view_models/my_home_page_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  TextEditingController _nameTextController;
  TextEditingController _placeTextController;
  String gender;
  double age;
  bool status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gender = "Male";
    status = true;
    age = 18;
    _nameTextController = TextEditingController();
    _placeTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MyHomePageVm>(
          builder: (_, vm, child){
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _nameTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Enter user's name",
                        hintStyle: TextStyle(
                          color: AppColors.deepBlack.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Male",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Radio(
                                value: "Male",
                                groupValue: gender,
                                onChanged: (String value) {
                                  print(value);
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Female",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Radio(
                                value: "Female",
                                groupValue: gender,
                                onChanged: (String value) {
                                  print(value);
                                  setState(() {
                                    gender = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Age (${age.toStringAsFixed(0)})",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Slider(
                      min: 0,
                      max: 100,
                      value: age,
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Radio(
                                value: true,
                                groupValue: status,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "In Active",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Radio(
                                value: false,
                                groupValue: status,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    status = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Place",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _placeTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: "Enter user's place",
                        hintStyle: TextStyle(
                          color: AppColors.deepBlack.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: ()async{
                        if(_nameTextController.text.trim()!="" && _placeTextController.text.trim()!=""){
                          int res = await vm.addNewUserToDb(_nameTextController.text, gender, age.toInt(), status, _placeTextController.text);
                          if(res!=null){
                            showSimpleNotification(
                              Text("${_nameTextController.text} added successfully"),
                              background: AppColors.primaryColor,
                            );
                            Navigator.pop(context);
                          }
                          else{
                            showSimpleNotification(
                              Text("Error adding ${_nameTextController.text}"),
                              background: AppColors.female,
                            );
                          }
                        }
                        else{
                          showSimpleNotification(
                            Text("Name or Place can not be empty"),
                            background: AppColors.female,
                          );
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: vm.isAddingNewUser?CircularProgressIndicator(backgroundColor: AppColors.white,):Text(
                            "Add User",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
