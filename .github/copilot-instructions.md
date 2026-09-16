# Copilot instructions — Oslo Codex iOS 27

Build a native **iPhone / iOS 27 / SwiftUI** album companion for **Oslo Codex** by **Jon Arve Ovesen** (Cybergroup Incorporated).

The full spec is [`AGENTS.md`](../AGENTS.md). Links live in [`Docs/LINKS.md`](../Docs/LINKS.md). App Store notes in [`Docs/APPSTORE.md`](../Docs/APPSTORE.md).

## Non-negotiables

- iPhone only, minimum iOS 27, Xcode 27, Swift 6.2, SwiftUI + Observation.
- Bundle ID `no.cybergroup.oslocodex`. Display name `Oslo Codex`.
- This is a real companion (listen, lyrics, Oslo map, widget, App Intents) — not a WKWebView of a landing page and not a grid of dead links.
- No accounts, no IAP, no trackers, no third-party SDKs for Spotify/YouTube. Deep links + MusicKit only.
- Hide any platform whose URL is `TBD` in `Docs/LINKS.md`.
- Liquid Glass on chrome only (tab bar, toolbars, listen sheet). Do not glass the whole content layer.
- Dark-first Nordic noir: bg `#07080C`, ice `#A7C4D8`, one neon accent `#3DFFB0`.
- Localize `en` + `nb-NO`. Norwegian must be real Norwegian.
- Do not ship unlicensed MP3s. Do not scrape. Do not invent lyrics.
- Keep `AGENTS.md`, `Docs/`, and this file when scaffolding the Xcode project.

## First implementation slice

Data models → TabView + glass chrome → Home + Listen sheet with working deep links → Tracks → Places → Artist → Widget + App Intents → nb-NO → icons.

Seed one track named **Oslo Codex** pointing at SoundCloud and the YouTube Music playlist until the official ISRC list is added.
