import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/themes/theme.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        surfaceTintColor: AppColors.mainAccent,
        side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: color ?? AppColors.mainAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 15),
              child: Text(
                text,
                style:textStyle ?? AppTheme.themeData.textTheme.headlineLarge!
                    .copyWith(fontSize: 22,color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.borderColor,
    this.textStyle,
    this.verticalPadding,
  });
}
