
import 'package:flutter/material.dart';
import 'package:mobile/gen/assets.gen.dart';

import '../../../../core/constant/constant.dart';

class AuthOpWithGoogle extends StatelessWidget {
  const AuthOpWithGoogle({
    super.key,
    this.title = "Sign in with Google"
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: KSize.symmetricVertical,
        horizontal: KSize.symmetricHorizontalX,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0.5,
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withAlphaOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              Assets.images.pngs.googleIcon.path,
            ),
          ),
          const SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
