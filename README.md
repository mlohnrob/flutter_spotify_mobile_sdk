# flutter_spotify_mobile_sdk

A Flutter plugin made to interact with the Spotify Mobile SDK

### Api

#### Connecting/Authenticating

| Function  | Description                            | Android            | iOS                   |
| --------- | -------------------------------------- | ------------------ | --------------------- |
| init      | Connects the App to Spotify            | :heavy_check_mark: | :construction_worker: |
| terminate | disconnects from the Spotify AppRemote | :heavy_check_mark: | :construction_worker: |

#### Player Api

| Function               | Description                                                      | Android            | iOS                   |
| ---------------------- | ---------------------------------------------------------------- | ------------------ | --------------------- |
| crossfadeState         | Gets the current crossfade state (this is a getter)              | :heavy_check_mark: | :construction_worker: |
| playerState            | Gets the current player state (this is a getter)                 | :heavy_check_mark: | :construction_worker: |
| pause                  | Pauses the current track                                         | :heavy_check_mark: | :construction_worker: |
| play                   | Plays the given spotifyUri                                       | :heavy_check_mark: | :construction_worker: |
| queue                  | Queues given spotifyUri                                          | :heavy_check_mark: | :construction_worker: |
| resume                 | Resumes the current track                                        | :heavy_check_mark: | :construction_worker: |
| skipNext               | Skips to next track                                              | :heavy_check_mark: | :construction_worker: |
| skipPrevious           | Skips to previous track                                          | :heavy_check_mark: | :construction_worker: |
| seekTo                 | Seeks the current track to the given position in milliseconds    | :heavy_check_mark: | :construction_worker: |
| seekToRelativePosition | Adds to the current position of the track the given milliseconds | :heavy_check_mark: | :construction_worker: |
| playerContextEvents    | Subscribes to the current player context (this returns a stream) | :heavy_check_mark: | :construction_worker: |
| playerStateEvents      | Subscribes to the current player state (this returns a stream)   | :heavy_check_mark: | :construction_worker: |
| toggleShuffle          | Cycles through the shuffle modes                                 | :heavy_check_mark: | :construction_worker: |
| toggleRepeat           | Cycles through the repeat modes                                  | :heavy_check_mark: | :construction_worker: |

#### Images Api

| Function | Description                             | Android            | iOS                   |
| -------- | --------------------------------------- | ------------------ | --------------------- |
| getImage | Get the image from the given spotifyUri | :heavy_check_mark: | :construction_worker: |

#### User Api

| Function                | Description                                       | Android               | iOS                   |
| ----------------------- | ------------------------------------------------- | --------------------- | --------------------- |
| addToLibrary            | Adds the given spotifyUri to the users library    | :construction_worker: | :construction_worker: |
| getCapabilities         | Gets the current users capabilities               | :construction_worker: | :construction_worker: |
| getLibraryState         | Gets the current library state                    | :construction_worker: | :construction_worker: |
| removeFromLibrary       | Removes the given spotifyUri to the users library | :construction_worker: | :construction_worker: |
| subscribeToCapabilities | Subscribes to the current users capabilities      | :construction_worker: | :construction_worker: |
| subscribeToUserStatus   | Subscrives to the current users status            | :construction_worker: | :construction_worker: |

#### Connect Api

| Function            | Description                                 | Android            | iOS                   |
| ------------------- | ------------------------------------------- | ------------------ | --------------------- |
| switchToLocalDevice | Switch to play music on this (local) device | :heavy_check_mark: | :construction_worker: |

#### Content Api

| Function                   | Description | Android               | iOS                   |
| -------------------------- | ----------- | --------------------- | --------------------- |
| getChildrenOfItem          | tbd         | :construction_worker: | :construction_worker: |
| getRecommendedContentItems | tbd         | :construction_worker: | :construction_worker: |
| playContentItem            | tbd         | :construction_worker: | :construction_worker: |
