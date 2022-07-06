// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/paddle.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/foundation.dart';
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

class _RawKeyEvent extends Mock
    with _DiagnosticableToStringMixin
    implements RawKeyEvent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('KeyboardMovingBehavior', () {
    const downKey = LogicalKeyboardKey.arrowDown;
    const upKey = LogicalKeyboardKey.arrowUp;
    const speed = 10.0;

    flameTester.test('on downKey pressed', (game) async {
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

      final event = _RawKeyEvent();
      final keysPressed = {downKey};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY + speed));
    });

    flameTester.test('on upKey pressed', (game) async {
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

      final event = _RawKeyEvent();
      final keysPressed = {upKey};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY - speed));
    });

    flameTester.test('on no keys pressed', (game) async {
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

      final event = _RawKeyEvent();
      final keysPressed = <LogicalKeyboardKey>{};
      game.onKeyEvent(event, keysPressed);
      game.update(1);

      expect(paddle.position.y, equals(centerY));
    });
  });
}
