// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/entities/ball/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('MovementBehavior', () {
    flameTester.test('moves in direction of the Ball velocity', (game) async {
      final center = game.size / 2;
      final behavior = MovementBehavior();

      final ball = Ball.test(
        behavior: behavior,
        velocity: Vector2(10, 10),
        position: center,
      );
      await game.ensureAdd(ball);

      game.update(1);

      expect(ball.position.x, equals(center.x + 10));
    });

    group('reverse y-axis of velocity', () {
      flameTester.test(
        'when hitting the top',
        (game) async {
          final center = game.size / 2;
          final behavior = MovementBehavior();

          final ball = Ball.test(
            behavior: behavior,
            velocity: Vector2(0, -10),
            position: Vector2(center.x, 0),
          );
          await game.ensureAdd(ball);

          expect(ball.velocity.y, equals(-10));

          game.update(1);

          expect(ball.velocity.y, equals(10));
        },
      );

      flameTester.test(
        'when hitting the bottom',
        (game) async {
          final center = game.size / 2;
          final behavior = MovementBehavior();

          final ball = Ball.test(
            behavior: behavior,
            velocity: Vector2(0, 10),
            position: Vector2(center.x, game.size.y),
          );
          await game.ensureAdd(ball);

          expect(ball.velocity.y, equals(10));

          game.update(1);

          expect(ball.velocity.y, equals(-10));
        },
      );
    });
  });
}
