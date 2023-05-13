import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c8_str/models/task_model.dart';
import 'package:todo_c8_str/screens/edit_task.dart';
import 'package:todo_c8_str/shared/network/firebase/firebase_functions.dart';
import 'package:todo_c8_str/shared/styles/app_colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: DrawerMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            FirebaseFunctions.deleteTask(taskModel.id);
          },
          label: "Delete",
          flex: 2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), bottomLeft: Radius.circular(18)),
          backgroundColor: Colors.red,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (context) {
            Navigator.pushNamed(context, EditTask.routeName,
                arguments: taskModel);
          },
          label: "Edit",
          backgroundColor: Colors.blue,
          icon: Icons.edit,
        )
      ]),
      child: Card(
        margin: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Container(
                height: 100,
                child: VerticalDivider(
                  width: 3,
                  indent: 10,
                  endIndent: 10,
                  color: Theme.of(context).primaryColor,
                  thickness: 3,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: taskModel.status
                        ? Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: greenColor)
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    taskModel.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              Spacer(),
              taskModel.status
                  ? Text(
                      "Done!",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: greenColor),
                    )
                  : InkWell(
                      onTap: () {
                        taskModel.status = true;
                        FirebaseFunctions.updateTask(taskModel.id, taskModel);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 22, vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).primaryColor),
                          child: Icon(
                            Icons.done,
                            size: 30,
                            color: Colors.white,
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
// keytool -list -v -keystore c:\users\lenovo\.android\debug.keystore -alias androiddebugkey -storepass android -keypass android
