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
      case "getIsConnected":
        result.success(mSpotifyAppRemote.isConnected());
        return;
      case "initialize":
        final String initClientId = call.argument("clientId");
        final String initRedirectUri = call.argument("redirectUri");
        initialize(initClientId, initRedirectUri, result);
        return;
      case "play":
        final String playSpotifyUri = call.argument("spotifyUri");
        play(playSpotifyUri, result);
        return;
      case "queue":
        final String queueSpotifyUri = call.argument("spotifyUri");
        queue(queueSpotifyUri, result);
        return;
      case "pause":
        pause(result);
        return;
      case "resume":
        resume(result);
        return;
      case "skipNext":
        skipNext(result);
        return;
      case "skipPrev":
        skipPrev(result);
        return;
      case "toggleRepeat":
        toggleRepeat(result);
        return;
      case "toggleShuffle":
        toggleShuffle(result);
        return;
      case "seekTo":
      final long seekToPositionMs = call.argument("positionMs");
      seekTo(seekToPositionMs, result);
      return;
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

      try {
        mSpotifyAppRemote.connect(this.appContext, connectionParams, new Connector.ConnectionListener() {

          @Override
          public void onConnected(final SpotifyAppRemote spotifyAppRemote) {
            mSpotifyAppRemote = spotifyAppRemote;
            result.success(true);
          }

          @Override
          public void onFailure(final Throwable throwable) {
            result.error("Spotify App Remote Failure: ", throwable.getMessage(), "");
          }
        });
      } catch (Exception e) {
        result.error("SpotifyAppRemote connect failed", e.getMessage(), "");
      }

    } else {
      result.error("Error Connecting to App Remote! Client ID or Redirect URI is not set", "", "");
    }
  }

  private void disconnect(@NonNull final Result result) {
    try {
      SpotifyAppRemote.disconnect(mSpotifyAppRemote);
      result.success(true);
    } catch (Exception e) {
      result.error("Disconnect failed: ", e.getMessage(), "");
    }
  }

  private void play(@NonNull final String spotifyUri, @NonNull final Result result) {
    if (spotifyUri != null) {
      try {
        mSpotifyAppRemote.getPlayerApi().play(spotifyUri);
        result.success(true);
      } catch (Exception e) {
        result.error("Play failed: ", e.getMessage(), "");
      }
    } else {
      result.error("Play failed: [spotifyUri] is null", "", "");
    }
  }

  private void queue(@NonNull final String spotifyUri, @NonNull final Result result) {
    if (spotifyUri != null) {
      try {
        mSpotifyAppRemote.getPlayerApi().queue(spotifyUri);
        result.success(true);
      } catch (Exception e) {
        result.error("Queue failed: ", e.getMessage(), "");
      }
    } else {
      result.error("Queue failed: [spotifyUri] is null", "", "");
    }
  }

  private void pause(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().pause();
      result.success(true);
    } catch (Exception e) {
      result.error("Pause failed: ", e.getMessage(), "");
    }
  }

  private void resume(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().resume();
      result.success(true);
    } catch (Exception e) {
      result.error("Resume failed: ", e.getMessage(), "");
    }
  }


  private void skipNext(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().skipNext();
      result.success(true);
    } catch (Exception e) {
      result.error("Skip Next failed: ", e.getMessage(), "");
    }
  }


  private void skipPrev(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().skipPrevious();
      result.success(true);
    } catch (Exception e) {
      result.error("Skip Previous failed: ", e.getMessage(), "");
    }
  }


  private void toggleRepeat(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().toggleRepeat();
      result.success(true);
    } catch (Exception e) {
      result.error("Toggle Repeat Failed: ", e.getMessage(), "");
    }
  }


  private void toggleShuffle(@NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().toggleShuffle();
      result.success(true);
    } catch (Exception e) {
      result.error("Toggle Shuffle Failed: ", e.getMessage(), "");
    }
  }

  private void seekTo(@NonNull long positionMs, @NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().seekTo(positionMs);
      result.success(true);
    } catch (Exception e) {
      result.error("Seek to [positionMs] Failed: ", e.getMessage(), "");
    }
  }
}
