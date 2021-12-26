import 'package:flutter/material.dart';
import 'package:task_timer_flutter_project/Store/Store.dart';
import 'package:task_timer_flutter_project/TaskCard.dart';
import 'Models/TaskListItem.dart';

class TaskList extends StatelessWidget {
  final List<TaskListTile> value;
  const TaskList({Key? key, required this.value}) : super(key: key);

  void startTimer(String id) {
    var index = value.indexWhere((element) => element.taskId == id);
    value[index].startTime = DateTime.now().millisecondsSinceEpoch;
    Store.saveList(value);
  }

  void endTimer(String id, int endtime) {
    var index = value.indexWhere((element) => element.taskId == id);
    value[index].endTime = endtime;
    Store.saveList(value);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskListCard(
          tContent: value[index],
          startTimer: startTimer,
          endTimer: endTimer,
        );
      },
      itemCount: value.length,
    );
  }
}
