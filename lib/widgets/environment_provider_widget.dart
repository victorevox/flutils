import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class EnvironmentProvider<T> extends StatelessWidget {
  final Widget? child;
  final T env;
  final bool enableLabel;
  final Color? color;
  final Color? textColor;
  final String Function(T env) labelTextMapper;

  EnvironmentProvider({
    Key? key,
    this.child,
    required this.env,
    this.enableLabel = true,
    this.color,
    this.textColor,
    String Function(T env)? labelTextMapper,
  })  : labelTextMapper = labelTextMapper ??
            ((env) {
              return "$env";
            }),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _EnvInherintProvider<T>(
      child: Stack(
        textDirection: TextDirection.ltr,
        children: (<Widget?>[
          child,
        ]..addAll(enableLabel
            ? [
                Positioned(
                  top: 25,
                  left: -30,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: .15,
                      child: Transform.rotate(
                        angle: -math.pi * 45 / 180,
                        child: Container(
                          width: 140,
                          height: 22,
                          color: color ?? Colors.purple,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                labelTextMapper(env),
                                style: TextStyle(
                                  color: textColor ?? Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]
            : [])) as List<Widget>,
      ),
      env: env,
    );
  }

  static _EnvInherintProvider? of(BuildContext context) {
    return _EnvInherintProvider.of(context);
  }
}

class _EnvInherintProvider<T> extends InheritedWidget {
  final T env;

  _EnvInherintProvider({
    Key? key,
    required this.child,
    required this.env,
  }) : super(key: key, child: child);

  final Widget child;

  static _EnvInherintProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_EnvInherintProvider>();
  }

  @override
  bool updateShouldNotify(_EnvInherintProvider<T> oldWidget) {
    return oldWidget.env != env;
  }
}
