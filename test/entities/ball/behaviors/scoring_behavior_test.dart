// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/entities/ball/behaviors/behaviors.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ScoreBehavior', () {
    group('scores a point', () {
      testWithGame(
        'when hitting the left side',
        PongGame.new,
        (game) async {
          final center = game.size / 2;
          final behavior = ScoringBehavior();

          final ball = Ball.test(
            behavior: behavior,
            velocity: Vector2(-10, 0),
            position: Vector2(0, center.y),
          );
          await game.ensureAdd(ball);

          expect(game.playerOneScore!.score, equals(0));

          game.update(1);

          expect(game.playerOneScore!.score, equals(1));
        },
      );

      testWithGame(
        'when hitting the right side',
        PongGame.new,
        (game) async {
          final center = game.size / 2;
          final behavior = ScoringBehavior();

          final ball = Ball.test(
            behavior: behavior,
            velocity: Vector2(10, 0),
            position: Vector2(game.size.x, center.y),
          );
          await game.ensureAdd(ball);

          expect(game.playerTwoScore!.score, equals(0));

          game.update(1);

          expect(game.playerTwoScore!.score, equals(1));
        },
      );
    });
  });
}
