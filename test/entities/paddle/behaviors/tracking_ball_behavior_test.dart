// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_game.dart';

class _MockRandom extends Mock implements Random {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('TrackingBallBehavior', () {
    late Random random;

    setUp(() {
      random = _MockRandom();
    });

    flameTester.test(
      'does not track if the ball is on the other side',
      (game) async {
        final behavior = TrackingBallBehavior(random: random);
        final centerY = game.size.y / 2;

        final paddle = Paddle.test(
          center: Vector2(0, centerY),
          movingBehavior: behavior,
        );
        await game.ensureAdd(paddle);

        final ball = Ball.test(
          position: Vector2(game.size.x, 0),
        );
        await game.ensureAdd(ball);

        game.update(1);

        expect(paddle.center.y, equals(centerY));
      },
    );

    group('track the ball', () {
      setUp(() {
        when(() => random.nextInt(any())).thenReturn(1);
      });

      flameTester.test('when it is below the ball', (game) async {
        final behavior = TrackingBallBehavior(random: random);
        final centerY = game.size.y / 2;

        final paddle = Paddle.test(
          center: Vector2(0, centerY),
          movingBehavior: behavior,
        );
        await game.ensureAdd(paddle);

        final ball = Ball.test(
          position: Vector2(game.size.x / 2, game.size.y),
          velocity: Vector2(-10, 0),
        );
        await game.ensureAdd(ball);

        game.update(1);

        expect(paddle.center.y, equals(centerY + 100));
      });

      flameTester.test('when it is above the ball', (game) async {
        final behavior = TrackingBallBehavior(random: random);
        final centerY = game.size.y / 2;

        final paddle = Paddle.test(
          center: Vector2(0, centerY),
          movingBehavior: behavior,
        );
        await game.ensureAdd(paddle);

        final ball = Ball.test(
          position: Vector2(game.size.x / 2, 0),
          velocity: Vector2(-10, 0),
        );
        await game.ensureAdd(ball);

        game.update(1);

        expect(paddle.position.y, equals(centerY - 100));
      });
    });
  });

  group('Difficulty', () {
    test('toString', () {
      expect(Difficulty.easy.toString(), equals('Difficulty.easy'));
      expect(Difficulty.medium.toString(), equals('Difficulty.medium'));
      expect(Difficulty.hard.toString(), equals('Difficulty.hard'));
    });
  });
}
