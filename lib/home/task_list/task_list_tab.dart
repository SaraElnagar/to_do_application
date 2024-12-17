import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/task_list/task_list_item.dart';
import 'package:to_do_app/providers/list_provider.dart';

import '../../providers/app_config_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if (listProvider.taskList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);
    return Column(
      children: [
        !providerTheme.isDarkMode()
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: EasyDateTimeLine(
                  activeColor: Colors.transparent,
                  initialDate: listProvider.selectDate,
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                    listProvider.changeSelectDate(selectedDate);
                  },
                  headerProps: const EasyHeaderProps(
                    showHeader: false,
                    monthPickerType: MonthPickerType.switcher,
                    dateFormatter: DateFormatter.fullDateDMY(),
                  ),
                  dayProps: const EasyDayProps(
                    height: 100,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                      dayNumStyle: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      dayStrStyle: TextStyle(color: AppColors.primaryColor),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.whiteColor),
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: EasyDateTimeLine(
                  activeColor: Colors.transparent,
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                    listProvider.changeSelectDate(selectedDate);
                  },
                  headerProps: const EasyHeaderProps(
                    showHeader: false,
                    monthPickerType: MonthPickerType.switcher,
                    dateFormatter: DateFormatter.fullDateDMY(),
                  ),
                  dayProps: const EasyDayProps(
                    height: 100,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                      monthStrStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      dayNumStyle: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      dayStrStyle: TextStyle(color: AppColors.whiteColor),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: AppColors.backgroundDarkColor),
                    ),
                  ),
                ),
              ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskListItem(
                task: listProvider.taskList[index],
              );
            },
            itemCount: listProvider.taskList.length,
          ),
        )
      ],
    );
  }
}
