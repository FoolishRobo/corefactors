// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersList _$UsersListFromJson(Map<String, dynamic> json) {
  return UsersList(
    userList: (json['userList'] as List)
        ?.map(
            (e) => e == null ? null : Users.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UsersListToJson(UsersList instance) => <String, dynamic>{
      'userList': instance.userList,
    };

Users _$UsersFromJson(Map<String, dynamic> json) {
  return Users(
    Name: json['Name'] as String,
    Gender: json['Gender'] as String,
    Age: json['Age'] as int,
    Status: json['Status'] as bool,
    Place: json['Place'] as String,
  );
}

Map<String, dynamic> _$UsersToJson(Users instance) => <String, dynamic>{
      'Name': instance.Name,
      'Gender': instance.Gender,
      'Age': instance.Age,
      'Status': instance.Status,
      'Place': instance.Place,
    };
