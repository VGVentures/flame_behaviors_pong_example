// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('Paddle', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final paddle = Paddle.autonomous(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        expect(game.contains(paddle), isTrue);
      },
    );

    flameTester.test(
      'is arrows based',
      (game) async {
        final paddle = Paddle.arrows(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        final behavior = paddle.firstChild<KeyboardMovementBehavior>();

        expect(game.contains(paddle), isTrue);
        expect(behavior, isNotNull);
        expect(paddle.firstChild<TrackBallBehavior>(), isNull);
        expect(behavior!.upKey, equals(LogicalKeyboardKey.arrowUp));
        expect(behavior.downKey, equals(LogicalKeyboardKey.arrowDown));
      },
    );

    flameTester.test(
      'is WASD based',
      (game) async {
        final paddle = Paddle.wasd(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        final behavior = paddle.firstChild<KeyboardMovementBehavior>();

        expect(game.contains(paddle), isTrue);
        expect(behavior, isNotNull);
        expect(paddle.firstChild<TrackBallBehavior>(), isNull);
        expect(behavior!.upKey, equals(LogicalKeyboardKey.keyW));
        expect(behavior.downKey, equals(LogicalKeyboardKey.keyS));
      },
    );

    flameTester.test(
      'is autonomous',
      (game) async {
        final paddle = Paddle.autonomous(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        expect(game.contains(paddle), isTrue);
        expect(paddle.firstChild<TrackBallBehavior>(), isNotNull);
        expect(paddle.firstChild<KeyboardMovementBehavior>(), isNull);
      },
    );
  });
}
