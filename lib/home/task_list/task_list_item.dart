import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:to_do_app/providers/list_provider.dart';

import '../../model/task.dart';
import 'edit_task_item.dart';

class TaskListItem extends StatefulWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  var height;
  var width;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              onPressed: (context) {
                ///delete task
                FirebaseUtils.deleteTaskToFireStore(widget.task)
                    .timeout(const Duration(seconds: 1), onTimeout: () {
                  // print("task deleted successfully");
                  listProvider.getAllTasksFromFireStore();
                });
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        child: InkWell(
          onTap: () {
            if (!widget.task.isDone) {
              Navigator.pushNamed(context, EditTaskItem.routeName,
                  arguments: widget.task);
            }
            null;
          },
          child: Container(
              padding: const EdgeInsets.all(12),
              decoration: !providerTheme.isDarkMode()
                  ? BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(22),
                    )
                  : BoxDecoration(
                      color: AppColors.backgroundDarkColor,
                      borderRadius: BorderRadius.circular(22),
                    ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        height: height * 0.1,
                        width: 4,
                        color: widget.task.isDone
                            ? AppColors.greenColor
                            : AppColors.primaryColor,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            widget.task.title,
                            semanticsLabel: AppLocalizations.of(context)!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color: widget.task.isDone
                                        ? AppColors.greenColor
                                        : AppColors.primaryColor),
                          ),
                          Text(
                            widget.task.description,
                            semanticsLabel:
                                AppLocalizations.of(context)!.description,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                      widget.task.isDone
                          ? Text(
                              "Done!",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: AppColors.greenColor),
                            )
                          : InkWell(
                              onTap: () {
                                widget.task.isDone = true;
                                setState(() {});
                                FirebaseUtils.updateTaskToFireStoreIsDone(
                                        widget.task)
                                    .then((_) {
                                  // listProvider.getAllTasksFromFireStore();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01,
                                    horizontal: width * 0.05),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.primaryColor),
                                child: const Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                  size: 35,
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
