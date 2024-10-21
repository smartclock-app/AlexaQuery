import 'dart:io';

import 'package:alexaquery_dart/alexaquery_dart.dart';
import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';

void main() {
  var env = DotEnv(includePlatformEnvironment: true)..load();
  group('A group of tests', () {
    final alexaQuery = QueryClient(File('cookies.txt'));

    test('Check Status', () async {
      expect(await alexaQuery.login("testuser", ""), isFalse);
    });

    test('Login function', () async {
      String refreshToken = env["TOKEN"]!;

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
