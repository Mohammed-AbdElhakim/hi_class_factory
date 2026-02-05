import 'package:flutter/material.dart';

import '../../app.dart';
import '../constants/app_strings.dart';
import '../constants/app_styles.dart';
import '../helper/SharedPreferences/pref.dart';

extension ContextExtension on BuildContext {
  void setLang(String langCode) {
    MyApp.setLocale(this, Locale(langCode));
    Pref.saveStringToPref(key: AppStrings.langKey, value: langCode);
  }

  void showBottomSheet({required Widget yourBottomSheetBody}) {
    showModalBottomSheet(
      context: this,
      isDismissible: false,
      // isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return Column(
          children: [
            Expanded(child: yourBottomSheetBody),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: Text(
                    "S.of(sheetContext).close",
                    style: AppStyles.styleRegular16(
                      sheetContext,
                    ).copyWith(color: Theme.of(sheetContext).colorScheme.onSurface),
                  ),
                ),
                SizedBox(width: 24),
              ],
            ),
          ],
        );
      },
    );
  }

  void showAlertDialog({required Widget yourAlertDialogBody}) {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          content: SizedBox(
            width: MediaQuery.of(dialogContext).size.width * .5,
            child: yourAlertDialogBody,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                "S.of(dialogContext).close",
                style: AppStyles.styleRegular16(
                  dialogContext,
                ).copyWith(color: Theme.of(dialogContext).colorScheme.onSurface),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Dark / Light Mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Locale
  Locale get locale => Localizations.localeOf(this);

  String get languageCode => locale.languageCode;

  String? get countryCode => locale.countryCode;

  bool get isArabic => languageCode == AppStrings.arLangKey;

  bool get isEnglish => languageCode == AppStrings.enLangKey;
}
