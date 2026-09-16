# App Store notes — Oslo Codex

Apple rejects thin marketing wrappers. This app is a **companion**: lyrics, Oslo map, widget, App Intents, official listen links, MusicKit. Review notes should say that.

## Listing (draft)

| Field | Value |
| --- | --- |
| Name | Oslo Codex |
| Subtitle | Jon Arve Ovesen — Nordic rap noir |
| Bundle ID | `no.cybergroup.oslocodex` |
| SKU | `oslo-codex-ios` |
| Primary category | Music |
| Secondary | Lifestyle |
| Age rating | 12+ (occasional mature lyrics — confirm once lyrics land) |
| Privacy | Data Not Collected |
| Price | Free |
| Devices | iPhone |
| Minimum OS | iOS 27 |

### Description (EN)

Oslo Codex is the official iPhone companion for Jon Arve Ovesen's Nordic rap-noir album. Listen on Apple Music, Spotify, YouTube Music and SoundCloud. Read lyrics, walk the Oslo of the record — Karl Johan, Akerselva, MUNCH — and pin a Home Screen widget so the album stays one tap away.

The sound of the North. Calculated. Cold. Heart still warm.

### Description (nb-NO)

Oslo Codex er den offisielle iPhone-folgesvennen til Jon Arve Ovesens nordic rap-noir-album. Lytt pa Apple Music, Spotify, YouTube Music og SoundCloud. Les tekster, ga gjennom albumets Oslo — Karl Johan, Akerselva, MUNCH — og fest en widget pa Hjem-skjermen.

Lyden av nord. Kalkulert. Kald. Hjertet er varmt.

### Keywords

Oslo Codex,Jon Arve Ovesen,nordic rap,hip hop,Oslo,noir,Cybergroup,norsk rap,R&B

## Privacy

- No analytics, no ads, no ATT, no account.
- MusicKit: Apple Music user token only after the user taps Apple Music.
- Location: only if the user taps Navigate on a map pin. Map itself needs no permission.
- Nutrition Label: Data Not Collected (declare MusicKit + Location accurately at submit time if those paths are used).

NSAppleMusicUsageDescription:

> Oslo Codex uses Apple Music so you can play the album if you subscribe.

NSLocationWhenInUseUsageDescription (add only when Navigate ships):

> Oslo Codex uses your location only to open Maps directions to a place from the album.

## Review notes (paste into App Store Connect)

This is an official artist companion for the album Oslo Codex by Jon Arve Ovesen. There is no user-generated content, no gambling, no IAP, no account. Playback happens in Apple Music / Spotify / YouTube Music / SoundCloud via public deep links and MusicKit. The widget and App Intents exist so fans can start listening from Springboard and Siri.

## Screenshots checklist

1. Home / Codex hero with Listen now
2. Listen sheet — platform grid
3. Track detail + lyrics
4. Oslo map at night
5. Artist
6. Widget on Home Screen

Dark screenshots only.

## What the artist must drop in before 1.0

- [ ] Cover 3000x3000 + 1024 app icon
- [ ] Official tracklist, ISRC, durations, explicit flags
- [ ] Lyrics (markdown per track)
- [ ] Artist photo
- [ ] Spotify / Apple Music / Tidal / Deezer / Amazon / Bandcamp album URLs
- [ ] Confirm age rating against lyrics
- [ ] Confirm release year (spec currently says 2025)
