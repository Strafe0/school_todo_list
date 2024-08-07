import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  DismissibleBackground({
    super.key,
    required this.color,
    BorderRadius? borderRadius,
    required this.alignment,
    required this.padding,
    required this.icon,
    required this.iconColor,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(9);

  final Color color;
  final BorderRadius? borderRadius;
  final Alignment alignment;
  final EdgeInsets padding;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: padding,
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
