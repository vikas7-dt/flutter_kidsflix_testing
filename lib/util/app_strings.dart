import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class AppStrings
{
  static late BuildContext context;
  static late AppLocalizations l10n;
  static late String locale;

  static void init(BuildContext ctx){
    context = ctx;
    l10n = AppLocalizations.of(context);
    locale = Localizations.localeOf(context).languageCode;
  }

}