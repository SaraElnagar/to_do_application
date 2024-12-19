import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';

import '../../providers/app_config_provider.dart';
import '../../providers/list_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = "";
  String description = "";
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);
    listProvider = Provider.of<ListProvider>(context);
    return SingleChildScrollView(
      child: !providerTheme.isDarkMode()
          ? Container(
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.add_new_task,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_task_title;
                              }
                              return null;
                            },
                            onChanged: (text) {
                              title = text;
                            },
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enter_task_title,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.greyColor))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .please_enter_description_title;
                              }
                              return null;
                            },
                            onChanged: (text) {
                              description = text;
                            },
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .enter_description_title,
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.greyColor))),
                            maxLines: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.select_date,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                showCalender();
                              },
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addTask();
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  AppColors.primaryColor),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.add,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        ],
                      ))
                ],
              ))
          : Container(
              color: AppColors.blackColor,
              child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.add_new_task,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.whiteColor),
                        textAlign: TextAlign.center,
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_task_title;
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  title = text;
                                },
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: AppColors.darkGrey),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkGrey)),
                                    hintText: AppLocalizations.of(context)!
                                        .enter_task_title),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_description_title;
                                  }
                                  return null;
                                },
                                onChanged: (text) {
                                  description = text;
                                },
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: AppColors.darkGrey),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.darkGrey)),
                                    hintText: AppLocalizations.of(context)!
                                        .enter_description_title),
                                maxLines: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.select_date,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: AppColors.darkGrey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    showCalender();
                                  },
                                  child: Text(
                                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.whiteColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  addTask();
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      AppColors.primaryColor),
                                ),
                                child: Text(
                                  "Add",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              )
                            ],
                          ))
                    ],
                  )),
            ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      /// add task
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      FirebaseUtils.addTaskToFireStore(task).timeout(const Duration(seconds: 1),
          onTimeout: () {
        // print("task added successfully");
        listProvider.getAllTasksFromFireStore();

        /// refresh tasks
        Navigator.pop(context);
      });
    }
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    // if (chosenDate != null) {
    //   selectedDate = chosenDate;
    // }
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
