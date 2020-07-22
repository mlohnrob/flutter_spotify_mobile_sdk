package com.mlohnrob.FlutterSpotifySDK.spotify_mobile_sdk;

import androidx.annotation.NonNull;

import android.content.Context;

import java.util.HashMap;
import java.util.List;

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
import com.spotify.protocol.types.CrossfadeState;
import com.spotify.protocol.client.CallResult;
import com.spotify.protocol.types.Track;
import com.spotify.protocol.types.Artist;

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
      case "getCrossfadeState":
        getCrossFadeState(result);
        return;
      case "getPlayerState":
        getPlayerState(result);
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
        final int seekToPositionMs = call.argument("positionMs");
        seekTo((long) seekToPositionMs, result);
        return;
      case "seekToRelativePosition":
        final int seekToRelativePositionMilliseconds = call.argument("milliseconds");
        seekToRelativePosition((long) seekToRelativePositionMilliseconds, result);
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

  private void seekToRelativePosition(@NonNull long milliseconds, @NonNull Result result) {
    try {
      mSpotifyAppRemote.getPlayerApi().seekToRelativePosition(milliseconds);
      result.success(true);
    } catch (Exception e) {
      result.error("Seek to Relative Position [milliseconds] Failed: ", e.getMessage(), "");
    }
  }

  private void getCrossFadeState(@NonNull Result result) {
    HashMap<String, Object> crossFadeStateMap = new HashMap<String, Object>();
    try {
      mSpotifyAppRemote.getPlayerApi().getCrossfadeState().setResultCallback(crossfadeState -> {
        crossFadeStateMap.put("isEnabled", crossfadeState.isEnabled);
        crossFadeStateMap.put("duration", crossfadeState.duration);
        result.success(crossFadeStateMap);
      }).setErrorCallback(throwable -> {
        result.error("Get Crossfade State Failed: ", throwable.getMessage(), "");
      });
    } catch (Exception e) {
      result.error("Get Crossfade State Failed: ", e.getMessage(), "");
    }
  }

  private void getPlayerState(@NonNull Result result) {
    HashMap<String, Object> playerStateMap = new HashMap<String, Object>();
    HashMap<String, Object> trackMap = new HashMap<String, Object>();
    HashMap<String, Object> albumMap = new HashMap<String, Object>();
    HashMap<String, Object> artistMap = new HashMap<String, Object>();
    HashMap<String, Object> playbackOptionsMap = new HashMap<String, Object>();
    HashMap<String, Object> playbackRestrictionsMap = new HashMap<String, Object>();

    List<Map<String, String>> artistsList = new List<Map<String, String>>();
    try {
      mSpotifyAppRemote.getPlayerApi().getPlayerState().setResultCallback(playerState -> {
        albumMap.put("name", playerState.track.album.name);
        albumMap.put("uri", playerState.track.album.uri);

        artistMap.put("name", playerState.track.artist.name);
        artistMap.put("uri", playerState.track.artist.uri);

        for (Artist artist : playerState.track.artists) {
          HashMap<String, String> thisArtistMap = new HashMap<String, String>();
          thisArtistMap.put("name", artist.name);
          thisArtistMap.put("uri", artist.uri);
          artistsList.add(thisArtistMap);
        }

        trackMap.put("album", albumMap);
        trackMap.put("artist", artistMap);
        trackMap.put("artists", artistsList);

        playbackOptionsMap.put("isShuffling", playerState.playbackOptions.isShuffling);
        playbackOptionsMap.put("repeatMode", playerState.playbackOptions.repeatMode);

        playbackRestrictionsMap.put("canRepeatContext", playerState.playbackRestrictions.canRepeatContext);
        playbackRestrictionsMap.put("canRepeatTrack", playerState.playbackRestrictions.canRepeatTrack);
        playbackRestrictionsMap.put("canSkipNext", playerState.playbackRestrictions.canSkipNext);
        playbackRestrictionsMap.put("canSkipPrev", playerState.playbackRestrictions.canSkipPrev);
        playbackRestrictionsMap.put("canToggleShuffle", playerState.playbackRestrictions.canToggleShuffle);
        playbackRestrictionsMap.put("canSeek", playerState.playbackRestrictions.canSeek);

        playerStateMap.put("track", trackMap);
        playerStateMap.put("isPaused", playerState.isPaused);
        playerStateMap.put("playbackOptions", playbackOptionsMap);
        playerStateMap.put("playbackPosition", playerState.playbackPosition);
        playerStateMap.put("playbackRestrictions", playbackRestrictionsMap);
        playerStateMap.put("playbackSpeed", playerState.playbackSpeed);

        result.success(playerStateMap);
      }).setErrorCallback(throwable -> {
        result.error("Get Player State Failed: ", throwable.getMessage(), "");
      });
    } catch (Exception e) {
      result.error("Get Player State Failed: ", e.getMessage(), "");
    }
  }
}
