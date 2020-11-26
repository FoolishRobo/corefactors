
import 'package:corefactors/models/users_list.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  static Database _db;

  static const String DB_NAME = "Users.DB";
  static final _databaseVersion = 1;

  static const String TABLE = "Users";

  static const String Name = "Name";
  static const String Gender = "Gender";
  static const String Age = "Age";
  static const String Status = "Status";
  static const String Place = "Place";

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db = await initdb();
    return _db;
  }

  initdb()async{
    String path = join(await getDatabasesPath(), DB_NAME);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  _onCreate(Database db, int version)async{
    await db.execute("CREATE TABLE $TABLE ($Name VARCHAR PRIMARY KEY, $Gender VARCHAR, $Age INT, $Status BOOLEAN, $Place VARCHAR )");
  }

  Future<int> save (Users users)async{
    Database dbClient = await instance.db;
    var res;
    try {
      res = await dbClient.insert(TABLE, toMap(users));
    }
    catch(e){
      print("Insert error  = $e");
    }
    return res;
  }


  Future<List<Users>> getUsers()async{
    var dbClient = await instance.db;
    try {
      List<Map> maps = await dbClient.query(
          TABLE, columns: [Name, Gender, Age, Status, Place]);
      List<Users> users = [];
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          users.add(fromMap(maps[i]));
        }
      }
      return users;
    }
    catch(e){
      List<Users> myUsers;
      return myUsers;
    }
  }

  Future close()async{
    var dbClient = await instance.db;
    dbClient.close();
  }





  Map<String, dynamic> toMap(Users users){
    var map = <String, dynamic>{
      "Name": users.Name,
      "Gender": users.Gender,
      "Age": users.Age,
      "Status": users.Status,
      "Place": users.Place,
    };
    return map;
  }

  Users fromMap(Map<String, dynamic> map){
    Users users = Users(
      Name: map['Name'],
      Age: map['Age'],
      Gender: map['Gender'],
      Status: map['Status']==1?true:false,
      Place: map['Place'],
    );
    return users;
  }

}