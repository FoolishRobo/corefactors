import 'package:corefactors/models/users_list.dart';
import 'package:corefactors/services/endpoints.dart';
import 'package:corefactors/services/service.dart';

Future<List<Users>> getUsers()async{
  List<Users> usersList = await getHttpsServiceFuture(UserApi.fetchUsers, (json) => Users.fromJson(json));
  return usersList;
}