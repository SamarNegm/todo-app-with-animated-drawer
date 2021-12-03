import 'package:flutter_animated_drawer/models/task_model.dart';
import 'package:flutter_animated_drawer/models/user_mode.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Database db;
  Future<void> createDatabase() async {
    db = await openDatabase(
      'todoAnimated.db',
      version: 1,
      onCreate: (db, version) {
        db
            .execute(
                'CREATE TABLE tasks_table (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT, status TEXT,category TEXT)')
            .then((value) => print('table created..'))
            .onError((error, stackTrace) => {});
        db
            .execute(
                'CREATE TABLE profile_table (id INTEGER PRIMARY KEY, name TEXT,email TEXT,phone TEXT)')
            .then((value) => print('table profile created..'))
            .onError((error, stackTrace) => {});
      },
      onOpen: (db) {
        print('database opened..');
      },
    );
  }

  void InsertToProfileTable(users model) {
    db.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO profile_table(name,email,phone) VALUES ("${model.name}","${model.email}","${model.phone}")')
          .then((value) {})
          .catchError((error) {
        print(error.toString());
      });
    });
  }

  void InsertToDatabase(taskModel model) {
    db.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks_table(title,date,time,status,category) VALUES ("${model.title}","${model.data}","${model.time}","${model.status}","${model.category}")')
          .then((value) {})
          .catchError((error) {
        print(error.toString());
      });
    });
  }

  Future<List<Map>> GetProfileDaTa() async {
    List<Map> list = await db.rawQuery('SELECT * FROM profile_table');

    return list;
  }

  Future<List<Map>> GetCategoryDaTaFromDataBase(String category) async {
    List<Map> list = await db
        .rawQuery('SELECT * FROM tasks_table WHERE category =? ', [category]);

    return list;
  }

  Future<List<Map>> GetAllDaTa() async {
    List<Map> list = await db.rawQuery('SELECT * FROM tasks_table');

    return list;
  }

  void UpDateDataBase({String state, int id}) {
    db.transaction((txn) {
      txn
          .rawUpdate(
              'UPDATE tasks_table SET status = ? WHERE id = ?', [state, id])
          .then((value) {})
          .catchError((error) {
            print(error.toString());
          });
    });
  }

  Future<List<Map>> DeleteFromDataBase(int id) async {
    await db.rawDelete('DELETE FROM tasks_table WHERE id = ?', [id]);
    List<Map> list = await db.rawQuery('SELECT * FROM tasks_table');
    return list;
  }
}
