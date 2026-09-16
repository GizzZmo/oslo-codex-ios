# Oslo Codex — platform links

Single source of truth for URLs used by the iOS app.
Copy these into `OsloCodex/Data/PlatformLinks.swift`.
**Hide any row whose URL is `TBD`.** Never ship a dead button.

Listen CTA order on iPhone in Norway:

1. Apple Music
2. Spotify
3. YouTube Music
4. SoundCloud
5. Tidal
6. Deezer
7. Amazon Music
8. Bandcamp

## Live now

| Key | Platform | URL |
| --- | --- | --- |
| `youtubeMusicAlbum` | YouTube Music / album playlist | https://www.youtube.com/playlist?list=OLAK5uy_mqxm7ghcHbbK576Pw05FJYuBcI5sovotQ |
| `soundcloudTrack` | SoundCloud — Oslo Codex | https://soundcloud.com/jon_arve/oslo-codex-1 |
| `soundcloudArtist` | SoundCloud artist | https://soundcloud.com/jon_arve |
| `spotifyArtist` | Spotify artist | https://open.spotify.com/artist/1lYfFl2Ar26wZtEIfdeFSl |
| `appleMusicArtist` | Apple Music artist | https://music.apple.com/no/artist/jon-arve-ovesen/961720310 |
| `youtubeChannel` | YouTube | https://www.youtube.com/@JonArveOvesen |
| `youtubeTopic` | YouTube Topic | https://www.youtube.com/channel/UCLpYpA620ufQtnS8RQyu_JA |
| `x` | X | https://x.com/Jon_Arve |
| `facebook` | Facebook | https://www.facebook.com/JonArveOvesen/ |
| `github` | GitHub | https://github.com/GizzZmo |
| `suno` | Suno | https://suno.com/@cybergroup |
| `paypal` | Support | https://www.paypal.me/JonArve |
| `relatedSoundcloud` | Nordic Noir and Neon Circuits | https://soundcloud.com/jon_arve/nordic-noir-and-neon-circuits |

Share / canonical listen URL until DSP albums exist:

https://www.youtube.com/playlist?list=OLAK5uy_mqxm7ghcHbbK576Pw05FJYuBcI5sovotQ

Hashtags: `#OsloCodex` `#nordicrapnoir` `#rap` `#rnb`

## TBD — fill when DistroKid / TuneCore / distributor is live

Keep these keys stable. Empty string in code = hidden in UI.

| Key | Platform | URL |
| --- | --- | --- |
| `spotifyAlbum` | Spotify album | TBD |
| `appleMusicAlbum` | Apple Music album | TBD |
| `tidalAlbum` | Tidal album | TBD |
| `deezerAlbum` | Deezer album | TBD |
| `amazonMusicAlbum` | Amazon Music album | TBD |
| `bandcampAlbum` | Bandcamp album | TBD |

Native URL schemes (declare in `LSApplicationQueriesSchemes`):

```text
spotify
music
youtubemusic
soundcloud
tidal
deezer
youtube
twitter
fb
```

App URL types:

```text
oslocodex://listen
oslocodex://track/{id}
oslocodex://places
oslocodex://artist
```
