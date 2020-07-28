package com.mlohnrob.FlutterSpotifySDK.spotify_mobile_sdk.stream_handlers;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;

import com.spotify.android.appremote.api.PlayerApi;

public class PlayerContextHandler implements EventChannel.StreamHandler {

    private PlayerApi playerApi;

    public PlayerContextHandler(PlayerApi playerApi) {
        this.playerApi = playerApi;
    }

    @Override
    public void onListen(Object arguments, EventSink events) {
        // try {
        // playerApi.subscribeToPlayerContext().setEventCallback(playerContext -> {

        // // events.success(playerStateMap);
        // }).setErrorCallback(
        // throwable -> events.error("Get Player Context Events Failed",
        // throwable.getMessage(), ""));
        // } catch (Exception e) {
        // events.error("Get Player Context Events Failed", e.getMessage(), "");
        // }
    }

    @Override
    public void onCancel(Object arguments) {
        // TODO: Write onCancel process
    }
}