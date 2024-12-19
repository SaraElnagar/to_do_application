import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';

import '../../providers/app_config_provider.dart';
import '../../providers/app_config_provider_theme.dart';

class LanguageBottomSheet extends StatelessWidget {
  var providerTheme;
  var providerLanguage;

  @override
  Widget build(BuildContext context) {
    providerLanguage = Provider.of<AppConfigProvider>(context);
    providerTheme = Provider.of<AppConfigProviderTheme>(context);
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
                onTap: () {
                  providerLanguage.changeLanguage("en");
                },
                child: providerLanguage.appLanguage == "en"
                    ? getSelectedItem(
                        AppLocalizations.of(context)!.english, context)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.english, context)),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  providerLanguage.changeLanguage("ar");
                },
                child: providerLanguage.appLanguage == "ar"
                    ? getSelectedItem(
                        AppLocalizations.of(context)!.arabic, context)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.arabic, context)),
          ],
        ));
  }

  Widget getSelectedItem(String text, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !providerTheme.isDarkMode()
            ? Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.blackDarkColor),
              )
            : Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.whiteColor),
              ),
        const Icon(
          Icons.check,
          color: AppColors.primaryColor,
          size: 30,
        ),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text, BuildContext context) {
    return !providerTheme.isDarkMode()
        ? Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.blackDarkColor),
          )
        : Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.whiteColor),
          );
  }
}
