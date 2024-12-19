import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    /// get all tasks
    /// collection => documents => data
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection().get();
    // List<QueryDocumentSnapshot<Task>> ==> List<Task>
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter all tasks ==> select date
    ///30/7/2024
    taskList = taskList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    /// sorting tasks
    taskList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newSelectDate) {
    selectDate = newSelectDate;
    getAllTasksFromFireStore();
  }
}
