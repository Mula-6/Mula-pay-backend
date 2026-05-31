import 'package:flutter/material.dart';
import 'package:mobile/core/constant/test_styles.dart';

class CustomSectionHeadings extends StatelessWidget {
  const CustomSectionHeadings({
    super.key,
    this.seeMore,
    this.showSeeMore = true,
    this.title = "Recent transactions",
  });
  final String title;
  final VoidCallback? seeMore;
  final bool showSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: showSeeMore ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [
          Text(title, style: KTextStyles.titleMedium(context)),
          if(showSeeMore)
          InkWell(
            onTap: seeMore,
            child: Text(
              "See all",
              style: KTextStyles.labelMedium(
                context,
              ).copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

  

