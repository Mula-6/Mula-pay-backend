import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constant/constant.dart';

class DefaultAppBarBackButton extends StatelessWidget {
  const DefaultAppBarBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
   
      // margin: EdgeInsets.symmetric(horizontal: KSize.symmetricHorizontal),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withAlphaOpacity(0.2),
            Theme.of(context).colorScheme.secondary.withAlphaOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlphaOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        color: Colors.white,
        iconSize: 18,
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
