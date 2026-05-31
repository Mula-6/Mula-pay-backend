
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constant/constant.dart';

class NavigateSlideWidgets extends StatelessWidget {
  const NavigateSlideWidgets({super.key, this.onclick, required this.icon});

  final VoidCallback? onclick;
  final List<List<dynamic>> icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onSurface.withAlphaOpacity(0.3),
      ),
      child: InkWell(
        onTap: onclick,
        child: HugeIcon(icon: icon, color: KColors.backgroundLight),
      ),
    );
  }
}
