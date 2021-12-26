class TaskListTile {
  String title;
  String description;
  Duration tDuration;
  int? startTime;
  int? endTime;
  String taskId;

  TaskListTile({
    required this.title,
    required this.tDuration,
    required this.description,
    this.startTime,
    this.endTime,
    required this.taskId,
  });

  factory TaskListTile.fromJson(Map<String, dynamic> parsedJson) {
    var intDuration = parsedJson['tDuration'] ?? 0;
    return new TaskListTile(
      title: parsedJson['title'] ?? "",
      tDuration: Duration(milliseconds: intDuration),
      description: parsedJson['description'] ?? "",
      taskId: parsedJson['taskId'] ?? "",
      startTime: parsedJson['startTime'],
      endTime: parsedJson['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "tDuration": this.tDuration.inMilliseconds,
      "description": this.description,
      "taskId": this.taskId,
      "startTime": this.startTime,
      "endTime": this.endTime,
    };
  }
}
