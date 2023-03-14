import 'package:flutter/material.dart';

import 'package:to_do_app/task_model.dart';

class DetailesScreen extends StatefulWidget {
  const DetailesScreen({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<DetailesScreen> createState() => _DetailesScreenState();
}

class _DetailesScreenState extends State<DetailesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.taskModel.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            widget.taskModel.subTitle ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
          Icon(
            widget.taskModel.isDone ? Icons.check : Icons.close,
            color: widget.taskModel.isDone ? Colors.green : Colors.red,
            size: 200,
          ),
          Text(
              'this task was created on : ${widget.taskModel.dt.toString().substring(0, 10).replaceAll('-', '/')}')
        ]),
      ),
    );
  }
}
