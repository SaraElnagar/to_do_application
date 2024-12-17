import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  /// add task
  static Future<void> addTaskToFireStore(Task task) {
    /// create collection
    var taskCollection = getTasksCollection();

    /// create document
// var taskDocRef=taskCollection.doc();
    DocumentReference<Task> taskDocRef = taskCollection.doc();

    /// create auto id
    task.id = taskDocRef.id;

    return taskDocRef.set(task);
  }

  /// delete task
  static Future<void> deleteTaskToFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  /// update task 'isDone'
  static Future<void> updateTaskToFireStoreIsDone(Task task) {
    return getTasksCollection().doc(task.id).update({'isDone': task.isDone});
  }
}
