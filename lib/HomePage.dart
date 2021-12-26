import 'package:flutter/material.dart';
import 'package:task_timer_flutter_project/Store/Store.dart';
import 'package:task_timer_flutter_project/TaskForm.dart';
import 'package:task_timer_flutter_project/TaskList.dart';
import 'Models/TaskListItem.dart';

class TaskTimerHome extends StatefulWidget {
  const TaskTimerHome({Key? key}) : super(key: key);

  @override
  _TaskTimerHomeState createState() => _TaskTimerHomeState();
}

class _TaskTimerHomeState extends State<TaskTimerHome> {
  List<TaskListTile> tskl = [];
  void onTaskAdd(TaskListTile task) {
    setState(() {
      tskl.add(task);
      Store.saveList(tskl);
    });
  }

  Future initList() async {
    var list = await Store.getList();
    setState(() {
      tskl = list;
    });
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'TASK TIMER',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent[700],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskForm(
                      onTaskAdd: onTaskAdd,
                    )),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyanAccent[700],
      ),
      body: TaskList(
        value: tskl,
      ),
    );
  }
}
