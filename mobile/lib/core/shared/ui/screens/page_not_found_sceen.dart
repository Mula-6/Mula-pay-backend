import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:mobile/gen/assets.gen.dart';
import '../../../constant/constant.dart';
import '../../shared.dart';

class PageNotFoundSceen extends StatelessWidget {
  const PageNotFoundSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: KSize.symmetricVerticalX,
            horizontal: KSize.symmetricHorizontalXl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300,
                width: 200,
                child: Image(image: AssetImage(Assets.gifs.a404Gif.path)),
              ),
              Text(
                "Oops! Lost in the Digital Void",
                textAlign: TextAlign.center,
                style: KTextStyles.titleLarge(context).copyWith(
                  fontSize: 20,

                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              KSize.h4,
              Text("404 - Page Not Found", textAlign: TextAlign.center),
              KSize.h64,
              DefaultButton(
                borderRadius: BorderRadius.circular(12),
                icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
                text: "Back to previous",
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
