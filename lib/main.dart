import 'package:flame/game.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flame_behaviors_pong_example/widgets/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: PongGame(),
      initialActiveOverlays: const ['start'],
      overlayBuilderMap: {
        'start': (context, PongGame game) => StartOverlay(game: game),
      },
    ),
  );
}
