import 'package:app3/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesTabs extends StatefulWidget {
  final List<String> categories;
  const CategoriesTabs({super.key, required this.categories});

  @override
  State<CategoriesTabs> createState() => _CategoriesTabsState();
}

class _CategoriesTabsState extends State<CategoriesTabs> {
  int selectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ChoiceChip(
            label: Text(widget.categories[index]),
            selected: selectedIndex == index,
            showCheckmark: false,
            onSelected: (_) {
              setState(() {
                selectedIndex = index;
              });
            },

            selectedColor: AppColors.mainColor,
            backgroundColor: Colors.white,

            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: selectedIndex == index
                  ? Colors.white
                  : AppColors.textColor,
            ),

            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }
}
