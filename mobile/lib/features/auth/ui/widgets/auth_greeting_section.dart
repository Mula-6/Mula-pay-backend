import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';

class AuthGreetingSection extends StatelessWidget {
  const AuthGreetingSection({super.key,
  required this.heading,
  this.subHeading,
  });

  final String heading;
  final String? subHeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: KSize.symmetricHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.left,
              heading,
              style: KTextStyles.titleLarge(context).copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 24,
              ),
            ),
          ),
          if(subHeading != null)KSize.h4,
          if(subHeading != null)Text(
            textAlign: TextAlign.left,
            subHeading!,
          ),
        ],
      ),
    );
  }
}
