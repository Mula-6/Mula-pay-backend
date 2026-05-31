import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/core/shared/shared.dart';

import '../../../../core/constant/constant.dart';

class KycFormContainer extends StatelessWidget {
  const KycFormContainer({
    super.key,
    required this.colorScheme,
    required this.heading,
    required this.subHeading,
    this.formKey,
    this.readonly = false,
    this.validator,
    required this.hintText,
    this.maxLength,
    this.icon = FontAwesomeIcons.userShield,
    this.keyboardType,
    this.prefixWidget,
    this.controller,
    this.fieldOperation,
  });

  final ColorScheme colorScheme;
  final String heading, subHeading, hintText;
  final int? maxLength;
  final GlobalKey<FormState>? formKey;
  final IconData icon;
  final TextInputType? keyboardType;
  final Widget? prefixWidget;
  final bool readonly;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final VoidCallback? fieldOperation;

  @override
  Widget build(BuildContext context) {
    return SlideInAnimationWapper(
      child: GestureDetector(
        onTap: fieldOperation,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          width: double.infinity,
          constraints: BoxConstraints(minHeight: 150),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface.withAlphaOpacity(0.08),
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.secondary,
              ],
              stops: [0.0, 0.3, 1.0, 0.5],
            ),
            borderRadius: BorderRadius.circular(20),
        
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlphaOpacity(0.05),
                blurRadius: 30,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: colorScheme.primary.withAlphaOpacity(0.05),
                blurRadius: 20,
        
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading, style: KTextStyles.titleLarge(context)),
                        Text(
                          subHeading,
                          style: KTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(),
              const SizedBox(height: 10),
              InkWell(
                onTap: fieldOperation,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: controller,
                    readOnly: readonly,
                    validator: validator,
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      hintText: hintText,
                      counterText: "",
                      prefixIcon: prefixWidget,
                    ),
                    keyboardType: keyboardType,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
