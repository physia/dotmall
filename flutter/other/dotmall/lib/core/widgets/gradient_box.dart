import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  const GradientBox({
    super.key,
    required this.child,
    this.gradient,
    this.enabled = true,
    this.blendMode = BlendMode.srcIn,
    this.color,
  }) : assert(
            (gradient != null || color != null) &&
                !(gradient != null && color != null),
            "GradientBox must have either a gradient or a color and not both");

  final Widget child;
  final Gradient? gradient;
  final Color? color;
  final bool enabled;
  final BlendMode blendMode;

  @override
  Widget build(BuildContext context) {
    var _gradient = gradient ??
        LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color!.withOpacity(0.8),
            color!,
          ],
        );
    return enabled
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => _gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: child,
          )
        : child;
  }
}

class CGradientBox extends StatelessWidget {
  const CGradientBox({
    Key? key,
    required this.child,
    this.enabled = true,
    this.blendMode = BlendMode.srcIn,
  }) : super(key: key);
  final Widget child;
  final bool enabled;
  final BlendMode blendMode;

  static Gradient gradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 196, 27, 247),
      Color.fromARGB(255, 255, 0, 200),
    ],
  );
  static Color color = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return GradientBox(
      blendMode: blendMode,
      enabled: enabled,
      gradient: gradient,
      child: child,
    );
  }
}
