import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/ball/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flutter/material.dart';

/// {@template ball}
/// A ball that will move over the field.
/// {@endtemplate}
class Ball extends Entity with HasGameRef {
  /// {@macro ball}
  Ball()
      : this._(
          behaviors: [
            MovingBehavior(),
            PaddleCollidingBehavior(),
            ScoringBehavior(),
          ],
        );

  /// {@macro ball}
  ///
  /// Test constructor.
  @visibleForTesting
  Ball.test({
    Behavior? behavior,
    Vector2? velocity,
    Vector2? position,
  }) : this._(
          startVelocity: velocity,
          position: position,
          behaviors: [if (behavior != null) behavior],
        );

  Ball._({
    Vector2? startVelocity,
    super.position,
    Iterable<Behavior>? behaviors,
  }) : super(
          size: _ballSize,
          anchor: Anchor.center,
          children: [
            CircleComponent.relative(1, parentSize: _ballSize)
              ..paint = PongGame.paint
          ],
          behaviors: [
            PropagatingCollisionBehavior(CircleHitbox()),
            if (behaviors != null) ...behaviors,
          ],
        ) {
    if (startVelocity != null) {
      velocity.setFrom(startVelocity);
    }
  }

  static final _ballSize = Vector2.all(8);

  /// The maximum speed of the ball.
  static const maxSpeed = 128.0;

  /// The velocity of the ball.
  final velocity = Vector2.zero();

  /// The range of angle in degrees.
  final range = 45;

  /// Resets the ball to its initial position.
  void reset([Random? rnd]) {
    final random = rnd ?? Random();

    final angle = (-range + random.nextInt(range) + range) * degrees2Radians;
    final goingLeft = random.nextBool() ? -1 : 1;

    velocity.setValues(
      cos(angle) * goingLeft * maxSpeed,
      sin(angle) * goingLeft * maxSpeed,
    );

    position.setFrom(gameRef.size / 2);
  }
}
