import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/firebase/firebase_functions.dart';
import 'package:todo/model/task_model.dart';

class TaskComponent extends StatelessWidget {
  TaskModel taskModel;
  TaskComponent({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          // extentRatio: .7,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              onPressed: (context) {
                FirebaseFunctions.deleteTask(taskModel.id);
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              // spacing: 80,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                // open new view with argument
                // build ui
                // button to save model
              },
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                height: 90,
                width: 3,
                color: taskModel.isDone
                    ? Colors.green
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: taskModel.isDone
                          ? Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.green)
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      taskModel.desc,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              taskModel.isDone
                  ? Text(
                      "Done",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.green,
                          ),
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        taskModel.isDone = true;
                        FirebaseFunctions.updateTask(taskModel);
                      },
                      icon: const Icon(
                        Icons.done,
                        size: 40,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(69, 34),
                        iconColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
