import 'package:flutter/material.dart';
import 'package:jar_of_hearts/utils/app_colors.dart';

class GradientButton extends StatelessWidget {
  final Function onTap;
  final String text;
  const GradientButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: AppColors.gradient,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(text),
      ),
    );
  }
}
