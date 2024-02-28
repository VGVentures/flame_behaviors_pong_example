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

  group('Paddle', () {
    testWithGame(
      'loads correctly',
      TestGame.new,
      (game) async {
        final paddle = Paddle.autonomous(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        expect(game.contains(paddle), isTrue);
      },
    );

    testWithGame(
      'is arrows based',
      TestGame.new,
      (game) async {
        final paddle = Paddle.arrows(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        final behavior = paddle.firstChild<KeyboardMovingBehavior>();

        expect(game.contains(paddle), isTrue);
        expect(behavior, isNotNull);
        expect(paddle.firstChild<TrackingBallBehavior>(), isNull);
        expect(behavior!.upKey, equals(LogicalKeyboardKey.arrowUp));
        expect(behavior.downKey, equals(LogicalKeyboardKey.arrowDown));
      },
    );

    testWithGame(
      'is WASD based',
      TestGame.new,
      (game) async {
        final paddle = Paddle.wasd(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        final behavior = paddle.firstChild<KeyboardMovingBehavior>();

        expect(game.contains(paddle), isTrue);
        expect(behavior, isNotNull);
        expect(paddle.firstChild<TrackingBallBehavior>(), isNull);
        expect(behavior!.upKey, equals(LogicalKeyboardKey.keyW));
        expect(behavior.downKey, equals(LogicalKeyboardKey.keyS));
      },
    );

    testWithGame(
      'is autonomous',
      TestGame.new,
      (game) async {
        final paddle = Paddle.autonomous(center: Vector2.zero());
        await game.ready();
        await game.ensureAdd(paddle);

        expect(game.contains(paddle), isTrue);
        expect(paddle.firstChild<TrackingBallBehavior>(), isNotNull);
        expect(paddle.firstChild<KeyboardMovingBehavior>(), isNull);
      },
    );
  });
}
