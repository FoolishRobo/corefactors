import 'package:corefactors/api_vm_connector/api_vm_connector.dart';
import 'package:corefactors/db/db_helper.dart';
import 'package:corefactors/models/users_list.dart';
import 'package:flutter/material.dart';

class MyHomePageVm extends ChangeNotifier {
  bool isFetching = false;
  List<Users> myUsers;
  List<Users> activeUsers = [];
  List<Users> inactiveUsers = [];
  double expandedTabWidth;
  double tabWidth;
  bool isAddingNewUser = false;

  DBHelper dbHelper;

  Future fetchUser(BuildContext context) async {
    if (isFetching == false && myUsers == null) {
      List<Users> onlineUsers;
      expandedTabWidth = MediaQuery.of(context).size.width / 2 + 100;
      tabWidth = MediaQuery.of(context).size.width / 2 - 100;
      isFetching = true;

      dbHelper = DBHelper.instance;
      myUsers = await getUsersFromDB();

      onlineUsers = await getUsers();

      if (myUsers == null || myUsers.length == 0) {
        print("db empty");
        myUsers = onlineUsers;
        myUsers.forEach((user) {
          if (user.Status) {
            activeUsers.add(user);
          } else {
            inactiveUsers.add(user);
          }
        });
        isFetching = false;
        notifyListeners();
        uploadToDB(myUsers);
      } else {
        print("data present in db");
        isFetching = false;
        notifyListeners();
        if (onlineUsers != null) {
          onlineUsers.forEach((user) {
            if (!myUsers.contains(user)) {
              myUsers.add(user);
            }
          });
        }
        myUsers.forEach((user) {
          print(user.Status);
          if (user.Status) {
            activeUsers.add(user);
          } else {
            inactiveUsers.add(user);
          }
        });
        notifyListeners();
      }
    }
  }

  Future<List<Users>> getUsersFromDB() async {
    print("Fetching from database");
    return dbHelper.getUsers();
  }

  Future uploadToDB(List<Users> users) async {
    print("Uploading to database");
    await dbHelper.initdb();
    users.forEach((user) async {
      await dbHelper.save(user);
    });
  }

  Future<int> addNewUserToDb(
      String name, String gender, int age, bool status, String place) async {
    isAddingNewUser = true;
    notifyListeners();
    Users users = Users(
      Name: name,
      Gender: gender,
      Age: age,
      Status: status,
      Place: place,
    );
    await dbHelper.initdb();
    int res = await dbHelper.save(users);
    isAddingNewUser = false;
    if(status){
      activeUsers.add(users);
    }
    else{
      inactiveUsers.add(users);
    }
    notifyListeners();
    return res;
  }

  void switchUser(Users users) {
    if (activeUsers.contains(users)) {
      users.Status = !users.Status;
      activeUsers.remove(users);
      inactiveUsers.insert(0, users);
    } else {
      users.Status = !users.Status;
      inactiveUsers.remove(users);
      activeUsers.insert(0, users);
    }
    notifyListeners();
  }
}
