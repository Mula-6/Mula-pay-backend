import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';

class KycNumberFlowTag extends StatelessWidget {
  const KycNumberFlowTag({super.key, required this.val});
  final String val;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.5),
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
          val,
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
