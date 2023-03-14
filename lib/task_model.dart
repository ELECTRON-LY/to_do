import 'package:flutter/material.dart';

class TaskModel {
  String title;
  String? subTitle;
  bool isDone;
  DateTime dt;

  TaskModel(
      {required this.title,
      this.subTitle,
      this.isDone = false,
      required this.dt});
}
