import 'package:flutter/material.dart';
import 'package:todo_c8_str/models/task_model.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descController = TextEditingController();
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add New Task",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: titleController,
              autofocus: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return " please enter task title";
                } else if (value.length < 10) {
                  return " please enter at least 10 char";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text("Task title"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      BorderSide(color: Theme.of(context).primaryColor))),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: descController,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return " please enter task Description";
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text("Task Description"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                      BorderSide(color: Theme.of(context).primaryColor))),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: Text(
                "Select Time",
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  chooseDate();
                },
                child: Text(
                  selectedDate.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    TaskModel task = TaskModel(
                        title: titleController.text,
                        description: descController.text,
                        date: selectedDate.millisecondsSinceEpoch,
                        status: false);
                    FirebaseFunctions.addTaskToFirestore(task).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void chooseDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate != null) {
      selectedDate = DateUtils.dateOnly(chosenDate);
      setState(() {});
    }
  }
}
