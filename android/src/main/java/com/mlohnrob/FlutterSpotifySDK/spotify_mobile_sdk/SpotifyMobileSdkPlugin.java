package com.mlohnrob.FlutterSpotifySDK.spotify_mobile_sdk;

import androidx.annotation.NonNull;

import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.BinaryMessenger;

import com.spotify.android.appremote.api.ConnectionParams;
import com.spotify.android.appremote.api.Connector;
import com.spotify.android.appremote.api.SpotifyAppRemote;

import com.spotify.protocol.client.Subscription;
import com.spotify.protocol.types.PlayerState;
import com.spotify.protocol.types.Track;

/** SpotifyMobileSdkPlugin */
public class SpotifyMobileSdkPlugin implements FlutterPlugin, MethodCallHandler {
  private FlutterPluginBinding mFlutterPluginBinding;
  private MethodChannel methodChannel;

  private SpotifyAppRemote mSpotifyAppRemote;

  // SpotifyMobileSdkPlugin(FlutterPluginBinding flutterPluginBinding) {
  // mFlutterPluginBinding = flutterPluginBinding;
  // }

  @Override
  public void onAttachedToEngine(@NonNull final FlutterPluginBinding flutterPluginBinding) {
    mFlutterPluginBinding = flutterPluginBinding;
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(),
        "spotify_mobile_sdk");
    // channel.setMethodCallHandler(new
    // SpotifyMobileSdkPlugin(flutterPluginBinding));
    channel.setMethodCallHandler(new SpotifyMobileSdkPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It
  // supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new
  // Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith
  // to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith
  // will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both
  // be defined
  // in the same class.

  public static void registerWith(final Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "spotify_mobile_sdk");
    channel.setMethodCallHandler(new SpotifyMobileSdkPlugin());
  }

  @Override
  public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
    switch (call.method) {
      case "initialize":
        final String clientId = call.argument("clientId");
        final String redirectUri = call.argument("redirectUri");
        initialize(clientId, redirectUri, result);
        return;
      case "getPlatformVersion":
        result.success("ANDROID: " + android.os.Build.VERSION.RELEASE);
        return;
      default:
        result.notImplemented();
        return;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
  }

  // private static final String CLIENT_ID = "";
  // private static final String REDIRECT_URL = "";

  private void initialize(@NonNull final String clientId, @NonNull final String redirectUri,
      @NonNull final Result result) {
    if (clientId != null && redirectUri != null) {
      // result.success(true);
      final ConnectionParams connectionParams = new ConnectionParams.Builder(clientId).setRedirectUri(redirectUri)
          .showAuthView(true).build();

      result.success(true);

      mSpotifyAppRemote.connect(mFlutterPluginBinding.getApplicationContext(), connectionParams,
          new Connector.ConnectionListener() {

            @Override
            public void onConnected(final SpotifyAppRemote spotifyAppRemote) {
              mSpotifyAppRemote = spotifyAppRemote;
              result.success(true);
              // Log.d("Spotify App Remote connected!");

              // Logic to do after connection
              // connected();
            }

            @Override
            public void onFailure(final Throwable throwable) {
              // result.error("Spotify App Remote: ", throwable.getMessage());
              // Log.e("Spotify App Remote: ", throwable.getMessage(), throwable);

              // Something went wrong with connection
              // Handle errors here!
            }
          });

    } else {
      // result.error("Error Connecting to App Remote! Client ID or Redirect URI is
      // not set");
    }
  }

  private void disconnect(@NonNull final Result result) {
    try {
      SpotifyAppRemote.disconnect(mSpotifyAppRemote);
      result.success(true);
    } catch (final Exception e) {
      // result.error("Disconnect failed", e.getStackTrace());
    }
  }

  private void playPlaylist(@NonNull final String playlistId, @NonNull final Result result) {
    final String fullId = String.format("spotify:playlist:%s", playlistId);
    mSpotifyAppRemote.getPlayerApi().play(fullId);
  }
}
