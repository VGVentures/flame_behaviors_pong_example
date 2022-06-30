// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockRandom extends Mock implements Random {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('Ball', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final ball = Ball();
        await game.ready();
        await game.ensureAdd(ball);

        expect(game.contains(ball), isTrue);
      },
    );

    flameTester.test(
      'reset ball to center with a random direction',
      (game) async {
        final random = _MockRandom();
        when(() => random.nextInt(any())).thenReturn(0);
        when(random.nextBool).thenReturn(false);

        final ball = Ball.test(
          position: Vector2.zero(),
          velocity: Vector2.zero(),
        );
        await game.ready();
        await game.ensureAdd(ball);

        expect(ball.position, closeToVector(0, 0));
        expect(ball.velocity, closeToVector(0, 0));

        ball.reset(random);

        expect(ball.position, equals(game.size / 2));
        expect(ball.velocity, closeToVector(Ball.maxSpeed, 0));
      },
    );
  });
}
