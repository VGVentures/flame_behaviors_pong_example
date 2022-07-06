// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/entities/ball/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPaddle extends Mock implements Paddle {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PaddleCollidingBehavior', () {
    test('reverse x-axis of velocity when hitting a paddle', () {
      final behavior = PaddleCollidingBehavior();

      final ball = Ball.test(
        behavior: behavior,
        velocity: Vector2(-10, 0),
        position: Vector2.zero(),
      );

      expect(ball.velocity.x, equals(-10));

      behavior.onCollisionStart({}, _MockPaddle());

      expect(ball.velocity.x, equals(10));
    });
  });
}
