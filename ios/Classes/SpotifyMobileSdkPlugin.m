#import "SpotifyMobileSdkPlugin.h"
#if __has_include(<spotify_mobile_sdk/spotify_mobile_sdk-Swift.h>)
#import <spotify_mobile_sdk/spotify_mobile_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "spotify_mobile_sdk-Swift.h"
#endif

@implementation SpotifyMobileSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSpotifyMobileSdkPlugin registerWithRegistrar:registrar];
}
@end
