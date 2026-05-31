import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/shared/shared.dart';
import 'kyc_number_flag_tag.dart';

class KycCard extends StatelessWidget {
  const KycCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.number,
    this.status = false,
    
    
    this.addOp, this.isLoading = false,
  });

  final String title, subTitle, number;
  final bool status, isLoading;
  final VoidCallback? addOp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: KSize.symmetricHorizontalX),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.8),
    
            Theme.of(context).colorScheme.surface.withAlphaOpacity(0.95),
          ],
          stops: [0.2, 0.8],
        ),
        borderRadius: BorderRadius.circular(10),
    
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withAlphaOpacity(0.09),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(-3, -3),
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.surface.withAlphaOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KycNumberFlowTag(val: number),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: KTextStyles.titleMedium(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(subTitle, style: KTextStyles.bodySmall(context)),
                      ],
                    ),
                  ),
                ],
              ),
    
              const SizedBox(height: 10),
              Divider(),
              const SizedBox(height: 10),
    
              DefaultOutlinedButton(
                width: double.infinity,
                height: 40,
                onPressed: addOp,
                text: status == true? "Update": "Add",
                isLoading: isLoading,
              ),
            ],
          ),
    
          Positioned(
            right: 0,
            child: Row(
              children: [
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: status ? KColors.success : KColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
