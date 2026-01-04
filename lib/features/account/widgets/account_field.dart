import 'package:app3/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AccountField extends StatelessWidget {
  final Widget icon;
  final String text;
  const AccountField({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: AppColors.textColor,
          ),
        ],
      ),
    );
  }
}
