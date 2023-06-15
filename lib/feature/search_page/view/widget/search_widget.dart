import 'package:flutter/material.dart';

import '../../../../utils/constant/app_color.dart';
import '../../../../utils/constant/app_radius.dart';
import '../../../../utils/constant/app_spacing.dart';

class SearchWIdget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  const SearchWIdget({
    super.key,
    required this.controller,
    this.textInputAction,
    this.suffixIcon,
    this.onEditingComplete,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColor.primaryWhite.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.radius10,
          ),
          borderSide: const BorderSide(
            color: AppColor.primaryWhite,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.radius10,
          ),
          borderSide: const BorderSide(
            color: AppColor.primaryWhite,
          ),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColor.primaryWhite.withOpacity(0.5),
        ),
        suffixIcon: suffixIcon,
        hintText: 'What do you want to watch?',
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColor.primaryWhite.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
      ),
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
    );
  }
}
