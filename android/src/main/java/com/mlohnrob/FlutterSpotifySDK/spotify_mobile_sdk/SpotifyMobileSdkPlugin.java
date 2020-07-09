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
  private Context appContext;
  private MethodChannel methodChannel;

  private SpotifyAppRemote mSpotifyAppRemote;

  public static void registerWith(final Registrar registrar) {
    final SpotifyMobileSdkPlugin instance = new SpotifyMobileSdkPlugin();
    instance.onAttachedToEngine(registrar.context(), registrar.messenger());
  }

  @Override
  public void onAttachedToEngine(@NonNull final FlutterPluginBinding flutterPluginBinding) {
    onAttachedToEngine(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
  }

  private void onAttachedToEngine(Context appContext, BinaryMessenger messenger) {
    this.appContext = appContext;
    methodChannel = new MethodChannel(messenger, "spotify_mobile_sdk");
    methodChannel.setMethodCallHandler(this);
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

  @Override
  public void onMethodCall(@NonNull final MethodCall call, @NonNull final Result result) {
    switch (call.method) {
      case "initialize":
        final String clientId = call.argument("clientId");
        final String redirectUri = call.argument("redirectUri");
        initialize(clientId, redirectUri, result);
        return;
      case "playPlaylist":
        final String playlistId = call.argument("playlistId");
        playPlaylist(playlistId, result);
      default:
        result.notImplemented();
        return;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
  }

  private void initialize(@NonNull final String clientId, @NonNull final String redirectUri,
      @NonNull final Result result) {
    if (clientId != null && redirectUri != null) {
      final ConnectionParams connectionParams = new ConnectionParams.Builder(clientId).setRedirectUri(redirectUri)
          .showAuthView(true).build();

      SpotifyAppRemote.disconnect(mSpotifyAppRemote);

      mSpotifyAppRemote.connect(this.appContext, connectionParams, new Connector.ConnectionListener() {

        @Override
        public void onConnected(final SpotifyAppRemote spotifyAppRemote) {
          mSpotifyAppRemote = spotifyAppRemote;
          result.success(true);
        }

        @Override
        public void onFailure(final Throwable throwable) {
          result.error("Spotify App Remote: ", throwable.getMessage(), "");
        }
      });

    } else {
      result.error("Error Connecting to App Remote! Client ID or Redirect URI is not set", "", "");
    }
  }

  private void disconnect(@NonNull final Result result) {
    try {
      SpotifyAppRemote.disconnect(mSpotifyAppRemote);
      result.success(true);
    } catch (final Exception e) {
      result.error("Disconnect failed: ", e.getMessage(), "");
    }
  }

  private void playPlaylist(@NonNull final String playlistId, @NonNull final Result result) {
    if (playlistId != null && result != null) {
      final String fullId = String.format("spotify:playlist:%s", playlistId);
      try {
        mSpotifyAppRemote.getPlayerApi().play(fullId);
      } catch (final Exception e) {
        result.error("Play Playlist failed: ", e.getMessage(), "");
      }
    } else {
      result.error("Play Playlist failed: [playlistId] is null", "", "");
    }
  }
}
