import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/paddle.dart';
import 'package:flutter/services.dart';

/// {@template keyboard_moving_behavior}
/// A behavior that makes a paddle move up and down based on the user's
/// keyboard input.
/// {@endtemplate}
class KeyboardMovingBehavior extends Behavior<Paddle>
    with KeyboardHandler, HasGameRef {
  /// {@macro keyboard_moving_behavior}
  KeyboardMovingBehavior({
    this.speed = 100,
    required this.downKey,
    required this.upKey,
  });

  /// The up key.
  final LogicalKeyboardKey upKey;

  /// The down key.
  final LogicalKeyboardKey downKey;

  /// The speed at which the paddle moves.
  final double speed;

  /// The direction the paddle is moving in.
  ///
  /// 0 is not moving, -1 is moving up, 1 is moving down.
  double _movement = 0;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(upKey)) {
      _movement = -1;
    } else if (keysPressed.contains(downKey)) {
      _movement = 1;
    } else {
      _movement = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    parent.position.y += _movement * speed * dt;

    parent.position.y = parent.position.y.clamp(
      parent.size.y / 2 + Field.halfWidth,
      gameRef.size.y - parent.size.y / 2 - Field.halfWidth,
    );
  }
}
