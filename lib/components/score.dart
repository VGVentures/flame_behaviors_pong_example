import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flutter/material.dart';

/// {@template score}
/// A component that displays the score.
/// {@endtemplate}
class Score extends PositionComponent with HasGameRef {
  /// {@macro score}
  Score.left()
      : _textPaint = TextPaint(),
        super(anchor: Anchor.center);

  /// {@macro score}
  Score.right()
      : _textPaint = TextPaint(textDirection: TextDirection.rtl),
        super(anchor: Anchor.center);

  final TextPaint _textPaint;

  /// The current score.
  int score = 0;

  @override
  void onGameResize(Vector2 size) {
    position.setValues(
      (gameRef.size / 2).x +
          (_textPaint.textDirection == TextDirection.ltr ? 1 : -1) * 24,
      Field.width * 3,
    );
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    _textPaint.render(canvas, '$score', Vector2.zero(), anchor: anchor);
  }
}
