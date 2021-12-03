import 'package:flutter_animated_drawer/DataBase/database.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/models/task_model.dart';
import 'package:flutter_animated_drawer/screens/archived.dart';
import 'package:flutter_animated_drawer/screens/done.dart';
import 'package:flutter_animated_drawer/screens/task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppCupit extends Cubit<AppState> {
  AppCupit() : super(InitialState());
  static AppCupit get(context) => BlocProvider.of(context);
  List pages = [Task(), Done(), Archived()];
  bool addIcon = true;
  int selectedPageIndex = 0;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Map> TodayTasks = [];
  taskModel model = taskModel(title: '', data: '', time: '', status: '');
  MyDatabase myDB = MyDatabase();
  double TotalTasks = 0;
  double stdyTasks = 0;
  double personalTasks = 0;
  double workTasks = 0;
  List<Map> TotalTasksList = [];
  List<Map> stdyTasksList = [];
  List<Map> personalTasksList = [];
  List<Map> workTasksList = [];
  int changeButtomNavigationBar(int index) {
    selectedPageIndex = index;
    print(index);
    getFromDataBase();

    emit(ChngeAppBar());
    return selectedPageIndex;
  }

  void chanegeFloatingActionButtonIcon() {
    addIcon = !addIcon;
    emit(chanegeFloatingActionButtonIconState());
  }

  void createDatabase() {
    myDB.createDatabase().then((value) {
      getFromDataBase();
      emit(CreateDataBaseState());
      print('nooo');
    });
  }

  void insertToDataBase() {
    myDB.InsertToDatabase(model);
    getFromDataBase();
    emit(InsertToDataBaseState());
    getFromDataBase();
  }

  Future<List<Map>> getFromDataBase() async {
    print('getting data from database');
    emit(AppGetDatabaseLoadingState());
    await myDB.GetAllDaTa().then((value) {
      print(value.toString() + ' value********');
      List<Map> allTasks = value;
      TodayTasks = [];
      stdyTasksList = [];
      personalTasksList = [];
      workTasksList = [];
      stdyTasks = 0;
      workTasks = 0;
      personalTasks = 0;
      TotalTasks = allTasks.length.toDouble();
      for (int i = 0; i < allTasks.length; i++) {
        if (allTasks[i]['date'] == DateFormat.yMMMd().format(DateTime.now())) {
          TodayTasks.add(allTasks[i]);
        }
        if (allTasks[i]['category'] == 'study') {
          stdyTasksList.add(allTasks[i]);
          stdyTasks++;
        }
        if (allTasks[i]['category'] == 'work') {
          workTasksList.add(allTasks[i]);
          workTasks++;
        }
        if (allTasks[i]['category'] == 'personal') {
          personalTasksList.add(allTasks[i]);
          personalTasks++;
        }
      }
    }).catchError((Error) {
      print(Error + 'errorrrrrrrrrrrrrrr');
    });

    // await myDB.GetDaTaFromDataBase('done').then((value) {
    //   doneTasks = value;
    // });
    // await myDB.GetDaTaFromDataBase('archive').then((value) {
    //   archivedTasks = value;
    // });
    emit(AppGetDatabaseingState());

    return TodayTasks;
  }

  double getCaregoryData(String category) {
    print('work ...' + workTasks.toString());

    if (category.toLowerCase() == 'study') {
      print('study ...' + stdyTasks.toString());
      return stdyTasks;
    } else if (category.toLowerCase() == 'personal') {
      print('personal ...' + personalTasks.toString());

      return personalTasks;
    } else
      return workTasks;
  }

  Future<void> DeleteFromDataBase(int id) async {
    await myDB.DeleteFromDataBase(id);
    emit(AppGetDatabaseLoadingState());
    getFromDataBase();
    emit(DeleteDataBaseState());
  }

  Future<void> updateDataBase({String state, int id}) async {
    print(state);
    await myDB.UpDateDataBase(state: state, id: id);
    getFromDataBase();
    emit(UpdateDataBaseState());
  }
}
