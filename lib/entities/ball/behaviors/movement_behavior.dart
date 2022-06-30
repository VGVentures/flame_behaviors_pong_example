import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';

/// {@template movement_behavior}
/// A behavior that makes the ball move in a certain direction.
///
/// If it hits the top or bottom of the field it will reverse the velocity
/// y-axis.
/// {@endtemplate}
class MovementBehavior extends Behavior<Ball> with HasGameRef {
  @override
  void update(double dt) {
    parent.position += parent.velocity * dt;

    final hitTop = parent.position.y - parent.size.y <= 0;
    final hitBottom = parent.position.y >=
        gameRef.size.y - Field.halfWidth - parent.size.y / 2;

    // If we hit top or bottom, reverse the velocity value.
    if (hitTop || hitBottom) {
      parent.velocity.y *= -1;
    }
  }
}
