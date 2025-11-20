import 'dart:ui';
import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color>? borderGradientColors;
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final double borderWidth;
  final bool hasBlur;

  const GradientCard({
    super.key,
    required this.child,
    this.borderGradientColors,
    this.backgroundColor,
    this.borderRadius = 24,
    this.padding = const EdgeInsets.all(24),
    this.borderWidth = 2,
    this.hasBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ?? 
        (isDark ? Colors.white.withOpacity(0.05) : Colors.white);

    return Stack(
      children: [
        // Background with blur
        if (hasBlur)
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
            ),
          ),
        if (!hasBlur)
          Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        
        // Border gradient
        if (borderGradientColors != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                colors: borderGradientColors!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(borderWidth),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(borderRadius - borderWidth),
              ),
            ),
          ),
        
        // Border solid
        if (borderGradientColors == null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: borderWidth,
              ),
            ),
          ),
        
        // Content
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}

