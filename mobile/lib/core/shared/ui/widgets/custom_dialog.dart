import 'package:flutter/material.dart';
import 'package:mobile/core/constant/constant.dart';
import 'package:mobile/core/shared/ui/widgets/button/button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.heading, required this.subHeading, required this.proceedOp});
  final String heading, subHeading;
  final Function proceedOp;
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlphaOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon or Illustration
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withAlphaOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            
            // Heading
            Text(
             heading,
              style: KTextStyles.titleLarge(context).copyWith(
                letterSpacing: -0.5,
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 8),
            
            // Sub description
            Text(
              subHeading,
              style: KTextStyles.bodyMedium(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withAlphaOpacity(0.5)
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child:DefaultOutlinedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    text: "Cancel")
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DefaultButton(
                    onPressed: (){
                       Navigator.pop(context);
                      proceedOp.call();
                    },
                    text: "Proceed"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}