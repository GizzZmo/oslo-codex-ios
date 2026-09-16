# Oslo Codex — iOS 27 Album Companion

You are a senior iOS engineer. Scaffold and implement a production-quality native iPhone app that promotes the album **Oslo Codex** by **Jon Arve Ovesen**.

This is NOT a web wrapper and NOT a link-farm. It is a real album companion: listen (via platform deep links + MusicKit), read lyrics, explore Oslo locations from the record, share tracks, and pin a Home Screen widget.

Target: iPhone only. Minimum iOS 27. SwiftUI. Xcode 27. English UI with Norwegian locale support (`nb-NO`). Dark-first Nordic noir aesthetic.

| Key | Value |
| --- | --- |
| Repository | `GizzZmo/oslo-codex-ios` |
| Bundle ID | `no.cybergroup.oslocodex` |
| Display name | Oslo Codex |
| Artist | Jon Arve Ovesen (Jon-Arve Constantine Gronsberg-Ovesen) |
| Label / imprint | Cybergroup Incorporated |
| Genre | Nordic Rap Noir · Hip-Hop · R&B |
| Hashtags | `#OsloCodex` `#nordicrapnoir` |

Read [`Docs/LINKS.md`](Docs/LINKS.md) before hard-coding any URL. UI never hard-codes URLs — `Album.swift` + `PlatformLinks.swift` are the single source of truth.

---

## 1. Product

A cinematic iPhone companion for Oslo Codex. Mood: winter Oslo at night — Karl Johans gate, Akerselva, Munch, neon on wet asphalt, cold air, warm analog heart. Visual language: Nordic noir + neon circuits. Not generic music-app purple. Not cyberpunk clutter.

Primary jobs:

1. Make someone press Play on their preferred service in under two taps.
2. Make the album feel like a place (Oslo) and a story (the Codex).
3. Give fans something worth keeping on the Home Screen (widget + lock screen).

Out of scope: accounts, in-app purchase, social feed, comments, DRM streaming of full tracks inside the app (use official platform apps). A 30-45s preview clip bundled in the app is OK if licensed; otherwise use MusicKit previews and official deep links only.

---

## 2. Platform and architecture

- iOS 27 SDK, Swift 6.2, SwiftUI, Observation (`@Observable`), Swift Concurrency.
- iPhone only (`TARGETED_DEVICE_FAMILY = 1`). Support Dynamic Island devices and iOS 27 window resizability / size-class changes. Do not hard-code 390x844.
- No UIKit except where a system API has no SwiftUI surface.
- MV + services. No massive view models. No third-party UI kits.
- SPM only if a package is truly needed. Prefer Apple frameworks: SwiftUI, MusicKit, AppIntents, WidgetKit, LinkPresentation, MapKit, AVFoundation (previews). ActivityKit is not required for v1.
- Liquid Glass for chrome only (tab bar, toolbars, FABs, cards that float over artwork). Do NOT glass the entire content layer. Use `.glassEffect()`, `.tabBarMinimizeBehavior(.onScrollDown)`, `.tabViewBottomAccessory` for a mini-player / Listen now strip.
- App Intents are mandatory (SiriKit is deprecated). Ship: `PlayOsloCodexIntent`, `OpenTrackIntent`, `ShareAlbumIntent`, `OpenListenLinksIntent`. Donate them. Siri AI / Spotlight must be able to Play Oslo Codex on Apple Music and Open Oslo Codex listen links.
- Accessibility: Dynamic Type, VoiceOver labels in EN + nb-NO, Reduce Motion, sufficient contrast on neon-on-black. All listen buttons 44pt or larger.
- Privacy: no trackers, no third-party analytics, no ATT prompt. Privacy Nutrition Label: data not collected. MusicKit uses Music user token only if the user taps Apple Music.
- Localization: `Localizable.xcstrings` for `en` and `nb-NO`.

Suggested structure:

```text
OsloCodex/
  App/OsloCodexApp.swift
  App/RootTabView.swift
  Features/Home/
  Features/Tracks/
  Features/Lyrics/
  Features/Places/
  Features/Listen/
  Features/Artist/
  Design/Palette.swift
  Design/Typography.swift
  Design/Motion.swift
  Data/Album.swift
  Data/PlatformLinks.swift
  Data/Lyrics/
  Services/MusicService.swift
  Services/LinkOpener.swift
  Intents/
  Widgets/OsloCodexWidget/
Assets.xcassets
```

---

## 3. Album data

```swift
struct Album {
  let title = "Oslo Codex"
  let artist = "Jon Arve Ovesen"
  let imprint = "Cybergroup Incorporated"
  let year = 2025 // confirm against DSP release date
  let genres = ["Nordic Rap Noir", "Hip-Hop", "R&B"]
  let taglineEN = "The sound of the North. Calculated. Cold. Heart still warm."
  let taglineNB = "Lyden av nord. Kalkulert. Kald. Hjertet er varmt."
  let aboutEN = """
    Oslo Codex is a cinematic Nordic rap-noir record: winter weight on
    Karl Johan, Akerselva's dark rhythmic glow, lab ozone and pine,
    MPC as a vault clock. 90s G-Funk sub-bass, soulful synth leads,
    precise technical rap, high-fidelity polish. Oslo city, stand up.
    """
  let tracks: [Track] // official tracklist, ISRC, duration, credits
}
```

Until the official tracklist is provided, ship one seed track so the list cannot be empty (fail the build if `Album.tracks` is empty):

1. **Oslo Codex** — SoundCloud + YouTube Music playlist.

Hide any platform whose URL is still `TBD`. Never show a dead button. Full table: [`Docs/LINKS.md`](Docs/LINKS.md).

Deep-link rules:

- Prefer native schemes then universal links: `spotify:`, `music://`, `youtubemusic://`, `soundcloud://`, `tidal://`, `deezer://`.
- Always `UIApplication.shared.open` with https fallback.
- Detect installed apps via `canOpenURL` only for schemes declared in `LSApplicationQueriesSchemes`: `spotify`, `music`, `youtubemusic`, `soundcloud`, `tidal`, `deezer`, `youtube`, `twitter`, `fb`.
- Listen CTA order on iPhone in Norway: Apple Music → Spotify → YouTube Music → SoundCloud → Tidal → Deezer → Amazon Music → Bandcamp.

MusicKit:

- If the user is an Apple Music subscriber AND `appleMusicAlbum` is set, the primary CTA plays the album in the Music app via MusicKit.
- If not subscribed, the same button opens the Apple Music catalog page.
- Never fake a player over a YouTube/SoundCloud webview.

---

## 4. Screens (TabView, 4 tabs)

Use a floating Liquid Glass `TabView`.

### Tab 1 — Codex (Home)

Full-bleed album cover (`Assets.xcassets/Cover/OsloCodex`, 3000x3000, sRGB + darkened gradient). Hero: **OSLO CODEX** / Jon Arve Ovesen.

- Primary glass button: **Listen now** → Listen sheet.
- Secondary: **Share album** (`ShareLink` with artwork + link + hashtags).
- Tertiary: **Add to Apple Music** (MusicKit, if available).
- Below: 2-line logline, horizontal track scroller, Oslo place chips, related drop *Nordic Noir and Neon Circuits* (`https://soundcloud.com/jon_arve/nordic-noir-and-neon-circuits`).
- Motion: slow Ken-Burns on cover; parallax on scroll. Honor Reduce Motion.

### Tab 2 — Tracks

List: index, title, duration, explicit badge. Detail: cover, credits (writer/producer: Jon Arve Ovesen / Jon-Arve Constantine Gronsberg-Ovesen as applicable), lyrics from `Data/Lyrics/{slug}.md` ("Lyrics coming" if missing — never lorem), per-track Listen row, Share this track.

### Tab 3 — Oslo (Places)

MapKit, dark muted style. No GPS on launch — request only if the user taps Navigate. Seed annotations:

| Title | Coordinate (approx) | Note |
| --- | --- | --- |
| Karl Johans gate | 59.9133, 10.7389 | Verse geography |
| Akerselva | 59.9180, 10.7520 | Dark rhythmic glow |
| MUNCH | 59.9050, 10.7550 | Museum shadows |
| Oslo S | 59.9111, 10.7528 | Arrival |
| Ekeberg / city view | 59.9000, 10.7680 | Capital at night |

Custom neon pin, glass callout with a quote from the record. Listen here still opens the Listen sheet. Atmosphere, not a tour-guide app.

### Tab 4 — Artist

Photo, short bio (piano 1984, Cubase/Nuendo, Oslo / Eidsvoll, Cybergroup Incorporated). Links: X, Facebook, GitHub, YouTube, Suno, PayPal. Discography chips to Spotify/Apple Music artist pages. Keep it short.

---

## 5. Listen sheet

Large detent sheet, Liquid Glass, morphing from the Listen button (`.navigationTransition(.zoom)` + matched transition source).

2-column grid of platform tiles, monochrome icons on glass, Open in {App}. Haptics on tap. If the app is not installed: Opens in Safari / App Store.

ShareLink footer:

```text
Oslo Codex — Jon Arve Ovesen
Nordic rap noir from the capital.
{best available album URL}
#OsloCodex #nordicrapnoir
```

---

## 6. Widget (required for App Store substance)

`OsloCodexWidget` (WidgetKit):

- Small: cover + Listen (deep link to listen sheet).
- Medium: cover, title, artist, 3 platform buttons (Music, Spotify, YouTube Music).
- Lock Screen circular / rectangular: glyph + title.

URL types: `oslocodex://listen` and `oslocodex://track/{id}`. Widget is static + App Intent configurable (default track = album opener).

---

## 7. Visual design

```text
bg            #07080C
bgElevated    #10131A
ink           #E8EDF5
muted         #8B93A7
ice           #A7C4D8    // Oslo winter
neon          #3DFFB0    // one accent only — used sparingly
warn          #FF4D6A    // explicit / live
asphalt       #1B1E27
```

Dark is default; provide a restrained light mode. Titles: condensed grotesque or SF Pro `.largeTitle` + condensed width. Body: SF Pro. No meme type.

Cover: full-bleed, 6% film grain, vignette, thin ice-blue hairline. Replaceable by dropping one file into `Assets.xcassets/Cover`.

If no official cover is in the repo, generate a placeholder: black field, faint Oslo grid, wordmark OSLO CODEX, subtitle JON ARVE OVESEN, ice-blue rule. Mark the asset comment PLACEHOLDER.

---

## 8. Repo deliverables

A complete Xcode project that opens in Xcode 27 and builds for the iOS 27 simulator without extra setup.

Must include:

- `OsloCodex.xcodeproj` (or `.xcworkspace` if SPM needs it)
- App target + Widget extension target
- This `AGENTS.md` (keep it)
- `LICENSE` (MIT for source; music/artwork remain reserved)
- Xcode `.gitignore`
- `Docs/LINKS.md` and `Docs/APPSTORE.md` (keep them)
- Sample lyrics file for track 1 so the lyrics screen is not empty
- App icon set (1024) matching the placeholder cover
- Info.plist keys: `LSApplicationQueriesSchemes`, URL types `oslocodex`, `NSAppleMusicUsageDescription` = Oslo Codex uses Apple Music so you can play the album if you subscribe.
- No `NSLocationWhenInUseUsageDescription` until the user taps Navigate on a place. Map works without it.

README must state the Command-R steps above.

---

## 9. Quality bar

- Builds with zero warnings-as-errors on iOS 27.
- No force-try in app code. No leftover print debugging.
- Dark and light look intentional; dark is the hero.
- VoiceOver can complete listen on Spotify from Home.
- Reduce Motion disables Ken-Burns and zoom transitions.
- TBD platforms are hidden (empty URL = hidden).
- Do not embed Spotify/YouTube SDKs. Deep links only.
- Do not scrape. Do not ship unlicensed full MP3s.
- Do not mention competing AI tools in the UI.
- Norwegian copy must be actually Norwegian, not machine-awkward.

Implement in this order:

1. Data models + PlatformLinks + placeholder cover
2. App skeleton + TabView + Liquid Glass chrome
3. Home + Listen sheet + working deep links
4. Tracks + lyrics
5. Places map
6. Artist
7. Widget + App Intents + URL scheme
8. Localization nb-NO
9. README / Docs / icon (do not delete the spec files)

When finished, print: how to run in Simulator, which links are still TBD, what the artist must drop in (cover 3000px, tracklist+ISRC, lyrics, bio photo).
