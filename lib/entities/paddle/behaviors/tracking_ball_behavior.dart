import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flutter/material.dart';

/// {@template tracking_ball_behavior}
/// A behavior that makes the paddle track the ball.
/// {@endtemplate}
class TrackingBallBehavior extends Behavior<Paddle> with HasGameRef {
  /// {@macro tracking_ball_behavior}
  TrackingBallBehavior({
    this.difficulty = Difficulty.easy,
    @visibleForTesting Random? random,
  }) : _random = random ?? Random();

  /// The difficulty value, used to skew the tracking of the ball to make it
  /// harder for the "AI" to win.
  final Difficulty difficulty;

  final Random _random;

  double _speed = 0;

  @override
  void update(double dt) {
    final isLeft = parent.position.x < gameRef.size.x / 2;
    final ball = gameRef.firstChild<Ball>()!;
    final ballIsLeft = ball.velocity.x.isNegative;
    if (isLeft && !ballIsLeft || !isLeft && ballIsLeft) {
      return;
    }

    if (ball.center.y > parent.center.y &&
        _random.nextInt(difficulty.value) == 1) {
      _speed = 1;
    } else if (ball.center.y < parent.center.y &&
        _random.nextInt(difficulty.value) == 1) {
      _speed = -1;
    }
    parent.position.y += _speed * 100 * dt;

    parent.position.y = parent.position.y.clamp(
      parent.size.y / 2 + Field.halfWidth,
      gameRef.size.y - parent.size.y / 2 - Field.halfWidth,
    );
  }
}

/// {@template difficulty}
/// The difficulty type for tracking the ball.
/// {@endtemplate}
enum Difficulty {
  /// {@macro difficulty}
  ///
  /// Easiest difficulty.
  easy(4),

  /// {@macro difficulty}
  ///
  /// Medium difficulty.
  medium(3),

  /// {@macro difficulty}
  ///
  /// Hard difficulty.
  hard(2);

  /// {@macro difficulty}
  const Difficulty(this.value);

  /// The value of the difficulty.
  final int value;

  @override
  String toString() {
    return 'Difficulty.$name';
  }
}
