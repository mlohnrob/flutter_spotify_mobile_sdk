package com.mlohnrob.FlutterSpotifySDK.spotify_mobile_sdk.stream_handlers;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;

import com.spotify.android.appremote.api.PlayerApi;

import com.spotify.protocol.types.Artist;

public class PlayerStateHandler implements EventChannel.StreamHandler {

    private PlayerApi playerApi;

    public PlayerStateHandler(PlayerApi playerApi) {
        this.playerApi = playerApi;
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        HashMap<String, Object> playerStateMap = new HashMap<String, Object>();
        HashMap<String, Object> trackMap = new HashMap<String, Object>();
        HashMap<String, Object> albumMap = new HashMap<String, Object>();
        HashMap<String, Object> artistMap = new HashMap<String, Object>();
        HashMap<String, Object> playbackOptionsMap = new HashMap<String, Object>();
        HashMap<String, Object> playbackRestrictionsMap = new HashMap<String, Object>();

        List<HashMap<String, String>> artistsList = new ArrayList<HashMap<String, String>>();
        try {
            playerApi.subscribeToPlayerState().setEventCallback(playerState -> {
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
                trackMap.put("name", playerState.track.name);
                trackMap.put("uri", playerState.track.uri);
                trackMap.put("duration", playerState.track.duration);
                trackMap.put("isEpisode", playerState.track.isEpisode);
                trackMap.put("isPodcast", playerState.track.isPodcast);

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

                events.success(playerStateMap);
            }).setErrorCallback(
                    throwable -> events.error("Get Player State Events Failed", throwable.getMessage(), ""));
        } catch (Exception e) {
            events.error("Get Player State Events Failed", e.getMessage(), "");
        }
    }

    @Override
    public void onCancel(Object arguments) {
        // TODO: Write onCancel process
    }
}