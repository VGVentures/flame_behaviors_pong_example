// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCanvas extends Mock implements Canvas {}

class _FakeParagraph extends Fake implements Paragraph {}

class _FakeOffset extends Fake implements Offset {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Score', () {
    setUpAll(() {
      registerFallbackValue(_FakeParagraph());
      registerFallbackValue(_FakeOffset());
    });

    test('renders correctly', () async {
      final canvas = _MockCanvas();

      final score = Score.left();
      score.render(canvas);

      verify(() => canvas.drawParagraph(any(that: isA<Paragraph>()), any()));
    });
  });
}
