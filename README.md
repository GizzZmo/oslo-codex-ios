# Oslo Codex — iOS 27

Native iPhone companion for **Oslo Codex** by [Jon Arve Ovesen](https://open.spotify.com/artist/1lYfFl2Ar26wZtEIfdeFSl).
Nordic rap noir. Cybergroup Incorporated.

This app is a real album companion: official listen deep links, lyrics, Oslo places, artist links, a widget, and App Intents.

## Run in Simulator

```text
Open /home/runner/work/oslo-codex-ios/oslo-codex-ios/OsloCodex.xcodeproj in Xcode 27+
Select the OsloCodex scheme
Choose an iPhone simulator running iOS 27
Press Command-R
```

## Current live listen links

- YouTube Music: album playlist
- SoundCloud: Oslo Codex
- Spotify: artist page
- Apple Music: artist page

The following album URLs are still **TBD** and therefore hidden in the app until supplied in `Docs/LINKS.md`:

- Spotify album
- Apple Music album
- Tidal album
- Deezer album
- Amazon Music album
- Bandcamp album

## What the artist still needs to drop in

- Cover art `3000x3000`
- Final app icon source `1024x1024`
- Official tracklist, ISRCs, durations, explicit flags
- Final markdown lyrics per track
- Artist bio photo
- Album URLs for Spotify, Apple Music, Tidal, Deezer, Amazon Music, and Bandcamp

## Repository notes

- Bundle ID: `no.cybergroup.oslocodex`
- iPhone only, minimum iOS 27
- SwiftUI + Observation + WidgetKit + App Intents
- `AGENTS.md`, `Docs/`, and lyrics placeholders are preserved intentionally
