import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';

/// {@template paddle_colliding_behavior}
/// A behavior that collides with the paddle and bounces it off by reversing
/// the velocity x-axis.
/// {@endtemplate}
class PaddleCollidingBehavior extends CollisionBehavior<Paddle, Ball> {
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, Paddle other) {
    parent.velocity.x *= -1;
  }
}
