import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toJson(),
        );
  }

  static void addTask(TaskModel taskModel) {
    var collection = getTaskCollection();

    var docRef = collection.doc();
    taskModel.id = docRef.id;
    docRef.set(taskModel);
  }

  static Future<QuerySnapshot<TaskModel>> getTasks() async {
    CollectionReference<TaskModel> collection = getTaskCollection();

    return collection.get();
  }
}
