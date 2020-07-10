# flutter_spotify_mobile_sdk

A Flutter plugin made to interact with the Spotify Mobile SDK

### Api

#### Connecting/Authenticating

| Function               | Description                                          | Android               | iOS                   |
| ---------------------- | ---------------------------------------------------- | --------------------- | --------------------- |
| connectToSpotifyRemote | Connects the App to Spotify                          | :heavy_check_mark:    | :construction_worker: |
| logout                 | logs the user out and disconnects the app connection | :construction_worker: | :construction_worker: |

#### Player Api

| Function                 | Description                                                      | Android               | iOS                   |
| ------------------------ | ---------------------------------------------------------------- | --------------------- | --------------------- |
| getCrossfadeState        | Gets the current crossfade state                                 | :construction_worker: | :construction_worker: |
| getPlayerState           | Gets the current player state                                    | :construction_worker: | :construction_worker: |
| pause                    | Pauses the current track                                         | :heavy_check_mark:    | :construction_worker: |
| play                     | Plays the given spotifyUri                                       | :heavy_check_mark:    | :construction_worker: |
| queue                    | Queues given spotifyUri                                          | :heavy_check_mark:    | :construction_worker: |
| resume                   | Resumes the current track                                        | :heavy_check_mark:    | :construction_worker: |
| skipNext                 | Skips to next track                                              | :construction_worker: | :construction_worker: |
| skipPrevious             | Skips to previous track                                          | :construction_worker: | :construction_worker: |
| seekTo                   | Seeks the current track to the given position in milliseconds    | :construction_worker: | :construction_worker: |
| seekToRelativePosition   | Adds to the current position of the track the given milliseconds | :construction_worker: | :construction_worker: |
| subscribeToPlayerContext | Subscribes to the current player context                         | :construction_worker: | :construction_worker: |
| subscribeToPlayerState   | Subscribes to the current player state                           | :construction_worker: | :construction_worker: |
| getCrossfadeState        | Gets the current crossfade state                                 | :construction_worker: | :construction_worker: |
| toggleShuffle            | Cycles through the shuffle modes                                 | :construction_worker: | :construction_worker: |
| toggleRepeat             | Cycles through the repeat modes                                  | :construction_worker: | :construction_worker: |

#### Images Api

| Function | Description                             | Android               | iOS                   |
| -------- | --------------------------------------- | --------------------- | --------------------- |
| getImage | Get the image from the given spotifyUri | :construction_worker: | :construction_worker: |

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

| Function                   | Description                                 | Android               | iOS                   |
| -------------------------- | ------------------------------------------- | --------------------- | --------------------- |
| connectSwitchToLocalDevice | Switch to play music on this (local) device | :construction_worker: | :construction_worker: |

#### Content Api

| Function                   | Description | Android               | iOS                   |
| -------------------------- | ----------- | --------------------- | --------------------- |
| getChildrenOfItem          | tbd         | :construction_worker: | :construction_worker: |
| getRecommendedContentItems | tbd         | :construction_worker: | :construction_worker: |
| playContentItem            | tbd         | :construction_worker: | :construction_worker: |
