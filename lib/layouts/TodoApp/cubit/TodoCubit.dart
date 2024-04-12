import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../../moduels/archived_tasks/archived_tasks_screen.dart';
import '../../../moduels/done_tasks/done_tasks_screen.dart';
import '../../../moduels/new_tasks/new_tasks_screen.dart';
import 'TodoStates.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit () : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context); 

  int current_index = 0;
  Database? database;


  List<Widget> screens = [
    new_tasks_screen(),
    done_tasks_screen(),
    archived_tasks_screen(),
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks"
  ];

  void chagneIndex(int index){
    current_index = index;
    emit(AppcChangeBottomNavBarState());
  }

  bool isBottomSheetShown = false;
  IconData fabicon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}){
    isBottomSheetShown = isShow;
    fabicon = icon;
    emit(AppChangeBottomSheetState());
  }

  void createDatabase() {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, int version) { 
        print("Database Created");
        database.execute("Create Table tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)").then((value) {
          print("Tables Created");
        }).catchError((error){
          print('Error when creating Tables ${error.toString()}');
        });
      },
      onOpen: (database){
        GetFromDatabase(database);
        print("Database Opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({required String title, required String time, required String date}) async{
     await database!.transaction((txn) async {
      txn.rawInsert("INSERT INTO tasks(title,date,time,status) VALUES('$title','$date','$time','new')").then((value) {
        print("Inserted Successfully");
        emit(AppInsertDatabaseState());
        GetFromDatabase(database);
      }).catchError((error){
        print('Error when Inserting New Record ${error.toString()}');
      });
      //return null;

    });

  }

  List<Map> newTasks= [];
  List<Map> doneTasks= [];
  List<Map> archivedTasks= [];

  GetFromDatabase(database) {
     newTasks = [];
     doneTasks = [];
     archivedTasks = [];
     database!.rawQuery("Select * from tasks").then((value){
       value.forEach((element){
         if(element['status'] == 'new') {
           newTasks.add(element);
         } else if(element['status'] =='done')
           doneTasks.add(element);
         else
           archivedTasks.add(element);
         emit(AppGetDatabaseState());
       }
       );
     });



  }

  void UpdateDatabase({required String status , required int id}) async { 
    database?.rawUpdate(
          'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id],).then((value) {
          print("Updated Successfully");
          GetFromDatabase(database);
          emit(AppUpdateDatabaseState());


    });

  }

  void DeleteDatabase({ required int id}) async { 
    database?.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],).then((value) {
      print("Deleted Successfully");
      GetFromDatabase(database);
      emit(AppDeleteDatabaseState());


    });

  }

}
