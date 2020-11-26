import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';


part 'users_list.g.dart';

@JsonSerializable()
class UsersList{
  List<Users> userList;

  UsersList({@required this.userList});

  factory UsersList.fromJson(Map<String, dynamic> json) => _$UsersListFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListToJson(this);

}

@JsonSerializable()
class Users {
  final String Name;
  final String Gender;
  final int Age;
  bool Status;
  final String Place;

  Users({
    @required this.Name,
    @required this.Gender,
    @required this.Age,
    @required this.Status,
    @required this.Place,
  });

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);

}