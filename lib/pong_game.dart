import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_behaviors_pong_example/entities/entities.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The game mode that the game is in.
enum GameMode {
  /// Player vs. player mode.
  playerVsPlayer,

  /// Player vs. Computer mode.
  playerVsComputer,

  /// Computer vs. Computer mode.
  computerVsComputer,
}

/// An example Flame game built with Flame Behaviors.
class PongGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  /// Default paint used in the game.
  static final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  /// Score of the left player.
  Score? playerOneScore;

  /// Score of the right player.
  Score? playerTwoScore;

  @override
  Future<void> onLoad() async {
    // Set the viewport to the original game's size.
    camera.viewport = FixedSizeViewport(512, 256);

    final Ball ball;

    await addAll([
      // Draw the field on the screen.
      Field(),
      // Spawn a ball.
      ball = Ball(),
      // Create score components.
      playerOneScore = Score.left(),
      playerTwoScore = Score.right(),
      // Add a FPS counter if in debug mode.
      if (kDebugMode)
        FpsTextComponent(
          position: Vector2(size.x - Field.halfWidth, size.y - Field.halfWidth),
          anchor: Anchor.bottomRight,
          textRenderer: TextPaint(
            style: const TextStyle(fontSize: Field.width, color: Colors.green),
          ),
        ),
    ]);

    ball.reset();

    // Wait until everything is loaded and pause the game.
    await ready();
    paused = true;
  }

  /// Start the current game.
  Future<void> start(GameMode mode) async {
    if (!paused) {
      return; // Already started.
    }
    overlays.remove('start');
    final center = size / 2;

    switch (mode) {
      case GameMode.playerVsPlayer:
        await addAll([
          Paddle.wasd(center: Vector2(16, center.y)),
          Paddle.arrows(center: Vector2(size.x - 16, center.y)),
        ]);
        break;
      case GameMode.playerVsComputer:
        await addAll([
          Paddle.autonomous(center: Vector2(16, center.y)),
          Paddle.arrows(center: Vector2(size.x - 16, center.y)),
        ]);
        break;
      case GameMode.computerVsComputer:
        await addAll([
          Paddle.autonomous(center: Vector2(16, center.y)),
          Paddle.autonomous(center: Vector2(size.x - 16, center.y)),
        ]);
        break;
    }

    // Wait until everything is loaded and unpause the game.
    await ready();
    paused = false;
  }

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    // Return handled to prevent macOS noises.
    return KeyEventResult.handled;
  }
}
