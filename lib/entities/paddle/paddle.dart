import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// {@template paddle}
/// A paddle that can be controlled by the user.
/// {@endtemplate}
class Paddle extends Entity {
  Paddle._({
    required Vector2 center,
    required Behavior movingBehavior,
  }) : super(
          position: center,
          size: _paddleSize,
          anchor: Anchor.center,
          children: [
            RectangleComponent.relative(
              Vector2.all(1),
              parentSize: _paddleSize,
              paint: PongGame.paint,
            ),
            RectangleHitbox(),
          ],
          behaviors: [movingBehavior],
        );

  Paddle._withKeys({
    required Vector2 center,
    required LogicalKeyboardKey upKey,
    required LogicalKeyboardKey downKey,
  }) : this._(
          center: center,
          movingBehavior: KeyboardMovingBehavior(
            upKey: upKey,
            downKey: downKey,
          ),
        );

  /// {@macro paddle}
  ///
  /// Uses arrow keys.
  Paddle.arrows({
    required Vector2 center,
  }) : this._withKeys(
          center: center,
          upKey: LogicalKeyboardKey.arrowUp,
          downKey: LogicalKeyboardKey.arrowDown,
        );

  /// {@macro paddle}
  ///
  /// Uses WASD keys.
  Paddle.wasd({
    required Vector2 center,
  }) : this._withKeys(
          center: center,
          upKey: LogicalKeyboardKey.keyW,
          downKey: LogicalKeyboardKey.keyS,
        );

  /// {@macro paddle}
  ///
  /// Will track the ball autonomously.
  Paddle.autonomous({
    required Vector2 center,
  }) : this._(center: center, movingBehavior: TrackingBallBehavior());

  /// {@macro paddle}
  ///
  /// Test constructor.
  @visibleForTesting
  Paddle.test({
    required Vector2 center,
    required Behavior movingBehavior,
  }) : this._(center: center, movingBehavior: movingBehavior);

  static final Vector2 _paddleSize = Vector2(8, 50);
}
