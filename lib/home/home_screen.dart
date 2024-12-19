import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/setttings/settings_tab.dart';
import 'package:to_do_app/home/task_list/add_task_bottom_sheet.dart';
import 'package:to_do_app/home/task_list/task_list_tab.dart';

import '../providers/app_config_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<AppConfigProviderTheme>(context);

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: MediaQuery.of(context).size.height*0.18,
        title: !providerTheme.isDarkMode()
            ? Text(
                selectedIndex == 0
                    ? AppLocalizations.of(context)!.app_title
                    : AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.titleLarge)
            : Text(
                selectedIndex == 0
                    ? AppLocalizations.of(context)!.app_title
                    : AppLocalizations.of(context)!.settings,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.blackDarkColor)),
      ),
      bottomNavigationBar: !providerTheme.isDarkMode()
          ? BottomAppBar(
              padding: EdgeInsets.all(0),
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              // height: 100,
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: AppLocalizations.of(context)!.task_list),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppLocalizations.of(context)!.settings),
                ],
              ),
            )
          : BottomAppBar(
              color: AppColors.backgroundDarkColor,
              padding: EdgeInsets.all(0),
              shape: CircularNotchedRectangle(),
              notchMargin: 8,
              // height: 100,
              child: BottomNavigationBar(
                currentIndex: selectedIndex,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: AppLocalizations.of(context)!.task_list),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppLocalizations.of(context)!.settings),
                ],
              ),
            ),
      floatingActionButton: !providerTheme.isDarkMode()
          ? FloatingActionButton(
              onPressed: () {
                addTaskBottomSheet();
              },
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 35,
              ),
              shape: StadiumBorder(
                  side: BorderSide(color: AppColors.whiteColor, width: 5)),
              // RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(35),
              //     side: BorderSide(color: AppColors.whiteColor, width: 5)),
            )
          : FloatingActionButton(
              onPressed: () {
                addTaskBottomSheet();
              },
              child: Icon(
                Icons.add,
                color: AppColors.whiteColor,
                size: 35,
              ),
              shape: StadiumBorder(
                  side: BorderSide(color: AppColors.blackColor, width: 5)),
              // RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(35),
              //     side: BorderSide(color: AppColors.whiteColor, width: 5)),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            height: 80,
          ),
          Expanded(
            flex: 7,
            child: selectedIndex == 0 ? TaskListTab() : SettingsTab(),
            //tabs[selectedIndex],
          )
        ],
      ),
    );
  }

  void addTaskBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
// List<Widget> tabs=[TaskListTab(),SettingsTab()];
