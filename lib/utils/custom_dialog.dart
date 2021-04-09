import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static showError(
    BuildContext context, {
    String title = 'Error',
    String message = '',
    VoidCallback onPressed,
  }) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text(title),
          actionsPadding: EdgeInsets.symmetric(horizontal: 23),
          actions: [
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.primaryColor,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Close',
                    style: AppStyles.medium(),
                  ),
                ),
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    })
          ],
          content: Text(
            message,
            style: AppStyles.regular(),
          ),
        ));
  }

  static showInfo(
    BuildContext context, {
    String title = 'Info',
    String message = '',
    VoidCallback onPressed,
  }) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text(title),
          actionsPadding: EdgeInsets.symmetric(horizontal: 23),
          actions: [
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.primaryColor,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Close',
                    style: AppStyles.medium(),
                  ),
                ),
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    })
          ],
          content: Text(
            message,
            style: AppStyles.regular(),
          ),
        ));
  }
}
