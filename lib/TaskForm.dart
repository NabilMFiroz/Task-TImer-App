import 'package:flutter/material.dart';
import 'package:task_timer_flutter_project/MyWidgets/button_widget.dart';
import 'package:task_timer_flutter_project/MyWidgets/myTextfield.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:uuid/uuid.dart';
import 'Models/TaskListItem.dart';

class TaskForm extends StatefulWidget {
  final onTaskAdd;
  const TaskForm({Key? key, this.onTaskAdd}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState(onTaskAdd);
}

class _TaskFormState extends State<TaskForm> {
  final onTaskAdd;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool buttondisabled = true;
  Duration taskDuration = Duration(hours: 0, minutes: 0);
  var uuid = Uuid();
  _TaskFormState(this.onTaskAdd);

  void buttonDisabled() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        taskDuration.inSeconds != 0) {
      buttondisabled = false;
    } else {
      buttondisabled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    buttonDisabled();
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      appBar: AppBar(
        title: Text(
          'NEW TASK',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyTextFields(label: 'Task Title', controller: titleController),
                MyTextFields(
                  label: 'Description',
                  controller: descriptionController,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Task Duration:',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                DurationPicker(
                  duration: taskDuration,
                  onChange: (val) {
                    setState(() => taskDuration = val);
                  },
                  snapToMins: 5.0,
                ),
                SizedBox(height: 20),
                ButtonWidget(
                  disabled: buttondisabled,
                  fontSize: 23,
                  bgcolor: Colors.white,
                  color: Colors.black,
                  text: 'Add Task',
                  onClicked: () {
                    var task = TaskListTile(
                      title: titleController.text,
                      description: descriptionController.text,
                      tDuration: taskDuration,
                      taskId: uuid.v1(),
                    );
                    onTaskAdd(task);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
