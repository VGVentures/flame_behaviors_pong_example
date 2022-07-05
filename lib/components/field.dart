import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flutter/material.dart';

/// {@template field}
/// A component that visualizes the field.
/// {@endtemplate}
class Field extends Component with HasGameRef {
  /// The stroke width of the field.
  static const width = 8.0;

  /// The half width of the field.
  static const halfWidth = width / 2;

  /// The color of the field.
  static const backgroundColor = Color(0xFF363636);

  /// The rect used for drawing the middle line.
  static final _lineRect = Vector2.zero() & Vector2(halfWidth, width);

  static final _foregroundPaint = Paint()
    ..color = PongGame.paint.color
    ..strokeWidth = width
    ..isAntiAlias = false
    ..style = PaintingStyle.stroke;

  static final _backgroundPaint = Paint()
    ..color = backgroundColor
    ..isAntiAlias = false;

  static final _linePaint = Paint()
    ..color = PongGame.paint.color
    ..isAntiAlias = false;

  late Rect _gameRect;

  @override
  void onGameResize(Vector2 size) {
    _gameRect = Vector2.zero() & gameRef.size;
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..save()
      ..drawRect(_gameRect, _backgroundPaint)
      ..drawRect(_gameRect, _foregroundPaint)
      ..translate(gameRef.size.x / 2 - _lineRect.width / 2, halfWidth);

    for (var i = 0; i < gameRef.size.y / width; i++) {
      canvas
        ..drawRect(_lineRect, _linePaint)
        ..translate(0, width * 2);
    }
    canvas.restore();
  }
}
