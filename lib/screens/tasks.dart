import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_str/screens/widgets/task_widget.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';

import '../models/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Theme.of(context).primaryColor,
          height: 100,
          deactivatedColor: Theme.of(context).primaryColor,
          selectedTextColor: Colors.white,
          onDateChange: (newDate) {
            // New date selected
            setState(() {
              date = newDate;
            });
          },
        ),
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: FirebaseFunctions.getTasks(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    Text("Something went wrong"),
                    ElevatedButton(onPressed: () {}, child: Text("Try Again"))
                  ],
                ),
              );
            }

            var tasksList =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if (tasksList.isEmpty) {
              return Center(child: Text("No Tasks"));
            }
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskItem(tasksList[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: tasksList.length),
            );
          },
        )
      ],
    );
  }
}
