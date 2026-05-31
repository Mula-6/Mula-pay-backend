
import 'package:flutter/material.dart';

import '../../../../core/constant/colors.dart';

class RecipeintTagName extends StatelessWidget {
  const RecipeintTagName({super.key, required this.abbrivation});
  
  final String abbrivation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withAlphaOpacity(0.5),
            Theme.of(context).colorScheme.secondary.withAlphaOpacity(0.5),
            Theme.of(context).colorScheme.error.withAlphaOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.secondary.withAlphaOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          abbrivation.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

