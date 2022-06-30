// ignore_for_file: cascade_invocations

import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('Field', () {
    flameTester.testGameWidget(
      'renders correctly',
      setUp: (game, tester) async {
        final field = Field();
        await game.ensureAdd(field);
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('goldens/field.png'),
        );
      },
    );
  });
}
