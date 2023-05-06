import 'package:flutter/material.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();

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
                  "12/12/2021",
                  style: Theme.of(context).textTheme.bodySmall,
                )),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print("task added");
                  }
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }

  void chooseDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
  }
}
