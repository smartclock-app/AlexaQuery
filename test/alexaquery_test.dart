import 'dart:io';

import 'package:alexaquery_dart/alexaquery_dart.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final alexaQuery = QueryClient(File('cookies.txt'));

    test('Check Status', () async {
      expect(await alexaQuery.checkStatus("testuser"), isFalse);
    });

    test('Login function', () async {
      String refreshToken = Platform.environment["TOKEN"]!;

      expect(
        await alexaQuery.login(
          "testuser",
          refreshToken,
        ),
        isTrue,
      );
    });
  });
}
