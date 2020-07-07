package com.mlohnrob.FlutterSpotifySDK.spotify_mobile_sdk;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.spotify.android.appremote.api.ConnectionParams;
import com.spotify.android.appremote.api.Connector;
import com.spotify.android.appremote.api.SpotifyAppRemote;

import com.spotify.protocol.client.Subscription;
import com.spotify.protocol.types.PlayerState;
import com.spotify.protocol.types.Track;

/** SpotifyMobileSdkPlugin */
public class SpotifyMobileSdkPlugin implements FlutterPlugin, MethodCallHandler {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(),
        "spotify_mobile_sdk");
    channel.setMethodCallHandler(new SpotifyMobileSdkPlugin());

    this.context = flutterPluginBinding.getApplicationContext();
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
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "spotify_mobile_sdk");
    channel.setMethodCallHandler(new SpotifyMobileSdkPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "initialize":
        final String clientId = call.argument("clientId");
        final String redirectUri = call.argument("redirectUri");
        initialize(clientId, redirectUri, result);
        break;
      case "getPlatformVersion":
        result.success("ANDROID: " + android.os.Build.VERSION.RELEASE);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

  private SpotifyAppRemote mSpotifyAppRemote;
  // private static final String CLIENT_ID = "";
  // private static final String REDIRECT_URL = "";

  private void initialize(@NonNull String clientId, @NonNull String redirectUri, @NonNull Result result) {
    if (clientId != null && redirectUri != null) {
      ConnectionParams connectionParams = new ConnectionParams.Builder(clientId).setRedirectUri(redirectUri)
          .showAuthView(true).build();

      mSpotifyAppRemote.connect(this.context, connectionParams, new Connector.ConnectionListener() {

        @Override
        public void onConnected(SpotifyAppRemote spotifyAppRemote) {
          mSpotifyAppRemote = spotifyAppRemote;
          result.success(true);
          // Log.d("Spotify App Remote connected!");

          // Logic to do after connection
          // connected();
        }

        @Override
        public void onFailure(Throwable throwable) {
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

  private void disconnect(@NonNull Result result) {
    try {
      SpotifyAppRemote.disconnect(mSpotifyAppRemote);
      result.success(true);
    } catch (Exception e) {
      // result.error("Disconnect failed", e.getStackTrace());
    }
  }

  private void playPlaylist(@NonNull String playlistId, @NonNull Result result) {
    final String fullId = String.format("spotify:playlist:%s", playlistId);
    mSpotifyAppRemote.getPlayerApi().play(fullId);
  }
}
