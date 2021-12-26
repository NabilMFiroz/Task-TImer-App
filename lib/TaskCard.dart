import 'package:flutter/material.dart';
import 'package:task_timer_flutter_project/Models/TaskListItem.dart';
import 'package:task_timer_flutter_project/TimerCard.dart';

class TaskListCard extends StatelessWidget {
  final TaskListTile tContent;
  final startTimer;
  final endTimer;
  const TaskListCard(
      {Key? key, required this.tContent, this.startTimer, this.endTimer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool shouldAutoStart = false;
    bool ended = false;
    var cDuration = tContent.tDuration.inMilliseconds;
    if (tContent.endTime != null) {
      ended = true;
      cDuration = tContent.endTime!;
    } else if (tContent.startTime != null) {
      shouldAutoStart = true;
      cDuration = (tContent.startTime ?? 0) +
          cDuration -
          DateTime.now().millisecondsSinceEpoch;
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.fromLTRB(14, 20, 14, 0),
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.cyanAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      tContent.title,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TimerCard(
                    cContent: new Duration(milliseconds: cDuration),
                    endTimer: (eTime) => endTimer(tContent.taskId, eTime),
                    sTimer: () => startTimer(tContent.taskId),
                    autoStart: shouldAutoStart,
                    ended: ended,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                tContent.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
