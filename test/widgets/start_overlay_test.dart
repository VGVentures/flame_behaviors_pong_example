import 'package:flame_behaviors_pong_example/pong_game.dart';
import 'package:flame_behaviors_pong_example/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/helpers.dart';

class _MockPongGame extends Mock implements PongGame {}

void main() {
  group('StartOverlay', () {
    late PongGame pongGame;

    setUp(() {
      pongGame = _MockPongGame();

      registerFallbackValue(GameMode.computerVsComputer);
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(StartOverlay(game: pongGame));

      expect(find.byType(OutlinedButton), findsNWidgets(3));
      expect(find.byType(Text), findsNWidgets(4));
    });

    testWidgets('start computer vs computer mode', (tester) async {
      await tester.pumpApp(StartOverlay(game: pongGame));

      when(() => pongGame.start(any()))
          .thenAnswer((invocation) => Future.value());

      await tester.tap(find.byKey(const Key('computerVsComputer')));

      verify(() => pongGame.start(GameMode.computerVsComputer)).called(1);
    });

    testWidgets('start player vs computer mode', (tester) async {
      await tester.pumpApp(StartOverlay(game: pongGame));

      when(() => pongGame.start(any()))
          .thenAnswer((invocation) => Future.value());

      await tester.tap(find.byKey(const Key('playerVsComputer')));

      verify(() => pongGame.start(GameMode.playerVsComputer)).called(1);
    });

    testWidgets('start player vs player mode', (tester) async {
      await tester.pumpApp(StartOverlay(game: pongGame));

      when(() => pongGame.start(any()))
          .thenAnswer((invocation) => Future.value());

      await tester.tap(find.byKey(const Key('playerVsPlayer')));

      verify(() => pongGame.start(GameMode.playerVsPlayer)).called(1);
    });
  });
}
