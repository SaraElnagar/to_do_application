import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/app_config_provider.dart';

import '../../providers/list_provider.dart';

class EditTaskItem extends StatefulWidget {
  static const String routeName = "edit_task_item";

  @override
  State<EditTaskItem> createState() => _EditTaskItemState();
}

class _EditTaskItemState extends State<EditTaskItem> {
  Task? task;
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String title = "";
  String description = "";
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    Task? args = ModalRoute.of(context)!.settings.arguments as Task;
    task = args;
    title = task?.title ?? "";
    description = task?.description ?? "";
    selectedDate = task?.dateTime ?? DateTime.now();
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);
    listProvider = Provider.of<ListProvider>(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: !providerTheme.isDarkMode()
              ? Text(AppLocalizations.of(context)!.app_title,
                  style: Theme.of(context).textTheme.titleLarge)
              : Text(AppLocalizations.of(context)!.app_title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.blackColor)),
          titleSpacing: 0.1,
          leading: BackButton(
            color: !providerTheme.isDarkMode()
                ? AppColors.whiteColor
                : AppColors.blackColor,
          ),
          backgroundColor: AppColors.primaryColor),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            height: 80,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: providerTheme.isDarkMode()
                      ? AppColors.backgroundDarkColor
                      : AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: providerTheme.isDarkMode()
                              ? AppColors.whiteColor
                              : AppColors.blackColor),
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            initialValue: title,
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
                              hintStyle:
                                  const TextStyle(color: AppColors.lightGrey),
                              hintText: AppLocalizations.of(context)!
                                  .enter_task_title,
                              enabledBorder: !providerTheme.isDarkMode()
                                  ? const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.darkGrey,
                                      ),
                                    )
                                  : const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                              focusedBorder: !providerTheme.isDarkMode()
                                  ? const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.darkGrey,
                                      ),
                                    )
                                  : const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            initialValue: description,
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
                              hintStyle:
                                  const TextStyle(color: AppColors.lightGrey),
                              hintText: AppLocalizations.of(context)!
                                  .enter_description_title,
                              enabledBorder: !providerTheme.isDarkMode()
                                  ? const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.darkGrey,
                                      ),
                                    )
                                  : const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                              focusedBorder: !providerTheme.isDarkMode()
                                  ? const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.darkGrey,
                                      ),
                                    )
                                  : const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                            ),
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
                              onTap: showCalender,
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 40),
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                updateTaskToFireStore();
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    AppColors.primaryColor),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.save_changes,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateTaskToFireStore() {
    if (formKey.currentState?.validate() == true) {
      /// update task
      FirebaseUtils.getTasksCollection().doc(task!.id).update({
        "title": title,
        "description": description,
        "dateTime": selectedDate,
      }).timeout(const Duration(seconds: 1), onTimeout: () {
        // print("Task updated successfully");
        listProvider.getAllTasksFromFireStore();
        Navigator.pop(context);
      });
    }
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    // if (chosenDate != null) {
    //   selectedDate = chosenDate;
    // }
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
