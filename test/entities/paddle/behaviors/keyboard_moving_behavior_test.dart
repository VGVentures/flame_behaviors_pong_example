// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/paddle.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/helpers.dart';

mixin _DiagnosticableToStringMixin on Object {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class _KeyEvent extends Mock with _DiagnosticableToStringMixin implements KeyEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('KeyboardMovingBehavior', () {
    const downKey = LogicalKeyboardKey.arrowDown;
    const upKey = LogicalKeyboardKey.arrowUp;
    const speed = 10.0;

    testWithGame('on downKey pressed', TestGame.new, (game) async {
      final behavior = KeyboardMovingBehavior(
        downKey: downKey,
        upKey: upKey,
        speed: speed,
      );
      final centerY = game.size.y / 2;

      final paddle = Paddle.test(
        center: Vector2(0, centerY),
        movingBehavior: behavior,
      );
      await game.ensureAdd(paddle);

      final event = _KeyEvent();
      final keysPressed = {downKey};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY + speed));
    });

    testWithGame('on upKey pressed', TestGame.new, (game) async {
      final behavior = KeyboardMovingBehavior(
        downKey: downKey,
        upKey: upKey,
        speed: speed,
      );
      final centerY = game.size.y / 2;

      final paddle = Paddle.test(
        center: Vector2(0, centerY),
        movingBehavior: behavior,
      );
      await game.ensureAdd(paddle);

      final event = _KeyEvent();
      final keysPressed = {upKey};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY - speed));
    });

    testWithGame('on no keys pressed', TestGame.new, (game) async {
      final behavior = KeyboardMovingBehavior(
        downKey: downKey,
        upKey: upKey,
        speed: speed,
      );
      final centerY = game.size.y / 2;

      final paddle = Paddle.test(
        center: Vector2(0, centerY),
        movingBehavior: behavior,
      );
      await game.ensureAdd(paddle);

      final event = _KeyEvent();
      final keysPressed = <LogicalKeyboardKey>{};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY));
    });
  });
}
