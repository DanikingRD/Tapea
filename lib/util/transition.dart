import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TransitionEffect {
  fade,
  scale,
  rightToLeft,
  leftToRight,
  topToBottom,
  bottomToTop
}

extension TransitionEffectExtension on TransitionEffect {
  static Offset _value(TransitionEffect val) {
    switch (val) {
      case TransitionEffect.rightToLeft:
        return const Offset(1.0, 0.0);
      case TransitionEffect.leftToRight:
        return const Offset(-1.0, 0.0);
      case TransitionEffect.topToBottom:
        return const Offset(0.0, -1.0);
      case TransitionEffect.bottomToTop:
        return const Offset(0.0, 1.0);
      default:
        return const Offset(0.0, 0.0);
    }
  }

  Offset get value => _value(this);
}

class Transition extends PageRouteBuilder {
  /// Transition type
  ///
  /// Default to [TransitionEffect.FADE]
  final TransitionEffect transitionEffect;

  /// The widget below this widget in the tree

  /// An parametric animation easing curve, i.e. a mapping of the unit interval to the unit interval.
  ///
  /// Default to [Curves.ease]
  final Curve curve;

  final WidgetBuilder builder;
  Transition({
    required this.builder,
    this.transitionEffect = TransitionEffect.fade,
    this.curve = Curves.ease,
    RouteSettings? settings,
    Object? arguments,
  }) : super(
          /// Called to obtain the child widget.
          pageBuilder: (BuildContext context, animation, _) => builder(context),
          settings: settings,
          transitionsBuilder: (BuildContext context, animation, _, __) {
            switch (transitionEffect) {
              case TransitionEffect.fade:
                return FadeTransition(
                  opacity: animation,
                  child: builder(context),
                );
              case TransitionEffect.scale:
                return ScaleTransition(
                  scale: animation,
                  child: builder(context),
                );
              default:
                final tween = Tween(
                  begin: transitionEffect.value,
                  end: Offset.zero,
                ).chain(
                  CurveTween(
                    curve: curve,
                  ),
                );
                return SlideTransition(
                  transformHitTests: false,
                  position: animation.drive(tween),
                  child: builder(context),
                );
            }
          },
        );
}
