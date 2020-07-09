import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spotify_mobile_sdk/spotify_mobile_sdk.dart';

void main() {
  const MethodChannel channel = MethodChannel('spotify_mobile_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  // test('getPlatformVersion', () async {
  //   expect(await SpotifyMobileSdk.platformVersion, '42');
  // });
}
