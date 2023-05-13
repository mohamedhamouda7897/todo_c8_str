import 'package:flutter/material.dart';
import 'package:todo_c8_str/models/task_model.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';

class EditTask extends StatelessWidget {
  static const String routeName = "edit";
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = args.title;
    descController.text = args.description;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(label: Text("title")),
          ),
          TextFormField(
            controller: descController,
            decoration: InputDecoration(label: Text("description")),
          ),
          ElevatedButton(
              onPressed: () {
                args.title = titleController.text;
                args.description = descController.text;
                FirebaseFunctions.updateTask(args.id, args);
                Navigator.pop(context);
              },
              child: Text("Save Changes"))
        ],
      ),
    );
  }
}
