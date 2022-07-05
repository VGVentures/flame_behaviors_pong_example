// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/test_game.dart';

class _MockCanvas extends Mock implements Canvas {}

class _FakeParagraph extends Fake implements Paragraph {}

class _FakeOffset extends Fake implements Offset {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('Score', () {
    setUpAll(() {
      registerFallbackValue(_FakeParagraph());
      registerFallbackValue(_FakeOffset());
    });

    flameTester.test('renders correctly', (game) async {
      final canvas = _MockCanvas();

      final score = Score.left();
      score.render(canvas);

      verify(() => canvas.drawParagraph(any(that: isA<Paragraph>()), any()));
    });
  });
}
