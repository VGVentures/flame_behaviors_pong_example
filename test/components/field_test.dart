// ignore_for_file: cascade_invocations

import 'package:flame_behaviors_pong_example/components/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Field', () {
    testGolden(
      'renders correctly',
      goldenFile: 'goldens/field.png',
      game: TestGame(),
      (game) async {
        final field = Field();
        await game.ensureAdd(field);
      },
    );
  });
}
