// ignore_for_file: cascade_invocations

import 'package:flame_behaviors_pong_example/entities/paddle/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/paddle/paddle.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
  final flameTester = FlameTester<PongGame>(PongGame.new);

  group('PongGame', () {
    test('can be instantiated', () {
      expect(PongGame(), isA<PongGame>());
    });

    group('start', () {
      flameTester.test('does nothing if game is not paused', (game) async {
        game.paused = false;
        await game.start(GameMode.computerVsComputer);

        expect(game.children.whereType<Paddle>(), isEmpty);
      });

      flameTester.test('with player vs player mode', (game) async {
        await game.start(GameMode.playerVsPlayer);

        final paddles = game.children.whereType<Paddle>();

        expect(paddles.length, equals(2));
        expect(paddles.first.hasBehavior<KeyboardMovingBehavior>(), isTrue);
        expect(paddles.last.hasBehavior<KeyboardMovingBehavior>(), isTrue);
      });

      flameTester.test('with player vs computer mode', (game) async {
        await game.start(GameMode.playerVsComputer);

        final paddles = game.children.whereType<Paddle>();

        expect(paddles.length, equals(2));
        expect(paddles.first.hasBehavior<TrackingBallBehavior>(), isTrue);
        expect(paddles.last.hasBehavior<KeyboardMovingBehavior>(), isTrue);
      });

      flameTester.test('with computer vs computer mode', (game) async {
        await game.start(GameMode.computerVsComputer);

        final paddles = game.children.whereType<Paddle>();

        expect(paddles.length, equals(2));
        expect(paddles.first.hasBehavior<TrackingBallBehavior>(), isTrue);
        expect(paddles.last.hasBehavior<TrackingBallBehavior>(), isTrue);
      });
    });

    flameTester.test('onKeyEvent', (game) async {
      final event = _RawKeyEvent();
      final keysPressed = {LogicalKeyboardKey.pageDown};
      expect(game.onKeyEvent(event, keysPressed), KeyEventResult.handled);
    });
  });
}
