import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flutter/material.dart';

/// {@template start_overlay}
/// The start overlay is shown when the game is first started. Allowing the user
/// to select the game mode and the number of players.
/// {@endtemplate}
class StartOverlay extends StatelessWidget {
  /// {@macro start_overlay}
  const StartOverlay({
    super.key,
    required this.game,
  });

  static final _buttonStyle = ButtonStyle(
    side: MaterialStateProperty.all(
      const BorderSide(
        color: Colors.white,
        width: Field.halfWidth / 2,
      ),
    ),
    foregroundColor: MaterialStateProperty.all(
      Colors.white,
    ),
    backgroundColor: MaterialStateProperty.all(
      Field.backgroundColor,
    ),
    overlayColor: MaterialStateProperty.all(
      Colors.white.withOpacity(0.1),
    ),
  );

  /// The game that this overlay belongs to.
  final PongGame game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Field.backgroundColor,
          border: Border.all(color: Colors.white, width: Field.halfWidth),
        ),
        width: 256,
        padding: const EdgeInsets.all(Field.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'PONG',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(height: Field.width),
            OutlinedButton(
              key: const Key('computerVsComputer'),
              onPressed: () => game.start(GameMode.computerVsComputer),
              style: _buttonStyle,
              child: const Text('Computer vs Computer'),
            ),
            const SizedBox(height: Field.width),
            OutlinedButton(
              key: const Key('playerVsComputer'),
              onPressed: () => game.start(GameMode.playerVsComputer),
              style: _buttonStyle,
              child: const Text('Player vs Computer'),
            ),
            const SizedBox(height: Field.width),
            OutlinedButton(
              key: const Key('playerVsPlayer'),
              onPressed: () => game.start(GameMode.playerVsPlayer),
              style: _buttonStyle,
              child: const Text('Player vs Player'),
            ),
          ],
        ),
      ),
    );
  }
}
