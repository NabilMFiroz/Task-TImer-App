import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_timer_flutter_project/Models/TaskListItem.dart';

class Store {
  static const _taskList = 'TaskList';

  static Future<List<TaskListTile>> getList() async {
    var _preferences = await SharedPreferences.getInstance();
    var savedTaskList = _preferences.getStringList(_taskList) ?? [];
    print(savedTaskList);
    List<TaskListTile> parsedTaskList = savedTaskList.map((e) {
      var parsedMap = jsonDecode(e);
      return TaskListTile.fromJson(parsedMap);
    }).toList();
    return parsedTaskList;
  }

  static Future saveList(List<TaskListTile> taskList) async {
    var _preferences = await SharedPreferences.getInstance();
    var stringTaskList = taskList.map((e) {
      var taskMap = e.toJson();
      return jsonEncode(taskMap);
    }).toList();
    var success = await _preferences.setStringList(_taskList, stringTaskList);
    print(success);
  }
}
