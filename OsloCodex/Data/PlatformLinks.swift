import Foundation

struct PlatformLink: Identifiable, Hashable {
    enum Kind: String, CaseIterable, Hashable, Sendable {
        case appleMusic
        case spotify
        case youTubeMusic
        case soundCloud
        case tidal
        case deezer
        case amazonMusic
        case bandcamp
        case youTube
        case x
        case facebook
        case github
        case suno
        case paypal
        case relatedSoundCloud
    }

    let kind: Kind
    let title: String
    let subtitle: String
    let nativeURL: URL?
    let webURL: URL

    var id: Kind { kind }

    var symbolName: String {
        switch kind {
        case .appleMusic: "music.note"
        case .spotify: "waveform"
        case .youTubeMusic: "play.rectangle.fill"
        case .soundCloud: "icloud.fill"
        case .tidal: "square.grid.2x2.fill"
        case .deezer: "slider.horizontal.3"
        case .amazonMusic: "cart.fill"
        case .bandcamp: "guitars.fill"
        case .youTube: "tv.fill"
        case .x: "bubble.left.and.bubble.right.fill"
        case .facebook: "person.2.fill"
        case .github: "chevron.left.forwardslash.chevron.right"
        case .suno: "sun.max.fill"
        case .paypal: "creditcard.fill"
        case .relatedSoundCloud: "sparkles"
        }
    }

    var bestURL: URL {
        nativeURL ?? webURL
    }
}

enum PlatformLinks {
    static let hashtags = ["#OsloCodex", "#nordicrapnoir", "#rap", "#rnb"]

    static let canonicalShareURL = URL(string: "https://www.youtube.com/playlist?list=OLAK5uy_mqxm7ghcHbbK576Pw05FJYuBcI5sovotQ")!
    private static let spotifyAlbumURLString = ""
    private static let appleMusicAlbumURLString = ""
    private static let tidalAlbumURLString = ""
    private static let deezerAlbumURLString = ""
    private static let amazonMusicAlbumURLString = ""
    private static let bandcampAlbumURLString = ""

    static let appleMusicArtist = PlatformLink(
        kind: .appleMusic,
        title: "Apple Music",
        subtitle: "Artist page",
        nativeURL: URL(string: "music://music.apple.com/no/artist/jon-arve-ovesen/961720310"),
        webURL: URL(string: "https://music.apple.com/no/artist/jon-arve-ovesen/961720310")!
    )

    static let spotifyArtist = PlatformLink(
        kind: .spotify,
        title: "Spotify",
        subtitle: "Artist page",
        nativeURL: URL(string: "spotify:artist:1lYfFl2Ar26wZtEIfdeFSl"),
        webURL: URL(string: "https://open.spotify.com/artist/1lYfFl2Ar26wZtEIfdeFSl")!
    )

    static let youTubeMusicAlbum = PlatformLink(
        kind: .youTubeMusic,
        title: "YouTube Music",
        subtitle: "Album playlist",
        nativeURL: URL(string: "youtubemusic://www.youtube.com/playlist?list=OLAK5uy_mqxm7ghcHbbK576Pw05FJYuBcI5sovotQ"),
        webURL: URL(string: "https://www.youtube.com/playlist?list=OLAK5uy_mqxm7ghcHbbK576Pw05FJYuBcI5sovotQ")!
    )

    static let soundCloudTrack = PlatformLink(
        kind: .soundCloud,
        title: "SoundCloud",
        subtitle: "Oslo Codex",
        nativeURL: URL(string: "soundcloud://soundcloud.com/jon_arve/oslo-codex-1"),
        webURL: URL(string: "https://soundcloud.com/jon_arve/oslo-codex-1")!
    )

    static let soundCloudArtist = PlatformLink(
        kind: .soundCloud,
        title: "SoundCloud",
        subtitle: "Artist page",
        nativeURL: URL(string: "soundcloud://soundcloud.com/jon_arve"),
        webURL: URL(string: "https://soundcloud.com/jon_arve")!
    )

    static let youTube = PlatformLink(
        kind: .youTube,
        title: "YouTube",
        subtitle: "Official channel",
        nativeURL: URL(string: "youtube://www.youtube.com/@JonArveOvesen"),
        webURL: URL(string: "https://www.youtube.com/@JonArveOvesen")!
    )

    static let x = PlatformLink(
        kind: .x,
        title: "X",
        subtitle: "@Jon_Arve",
        nativeURL: URL(string: "twitter://user?screen_name=Jon_Arve"),
        webURL: URL(string: "https://x.com/Jon_Arve")!
    )

    static let facebook = PlatformLink(
        kind: .facebook,
        title: "Facebook",
        subtitle: "Jon Arve Ovesen",
        nativeURL: nil,
        webURL: URL(string: "https://www.facebook.com/JonArveOvesen/")!
    )

    static let github = PlatformLink(
        kind: .github,
        title: "GitHub",
        subtitle: "GizzZmo",
        nativeURL: nil,
        webURL: URL(string: "https://github.com/GizzZmo")!
    )

    static let suno = PlatformLink(
        kind: .suno,
        title: "Suno",
        subtitle: "Cybergroup",
        nativeURL: nil,
        webURL: URL(string: "https://suno.com/@cybergroup")!
    )

    static let paypal = PlatformLink(
        kind: .paypal,
        title: String(localized: "support_title"),
        subtitle: String(localized: "support_subtitle"),
        nativeURL: nil,
        webURL: URL(string: "https://www.paypal.me/JonArve")!
    )

    static let relatedSoundCloud = PlatformLink(
        kind: .relatedSoundCloud,
        title: "Nordic Noir and Neon Circuits",
        subtitle: String(localized: "related_drop_subtitle"),
        nativeURL: URL(string: "soundcloud://soundcloud.com/jon_arve/nordic-noir-and-neon-circuits"),
        webURL: URL(string: "https://soundcloud.com/jon_arve/nordic-noir-and-neon-circuits")!
    )

    static let appleMusicAlbum = liveLink(
        urlString: appleMusicAlbumURLString,
        kind: .appleMusic,
        title: "Apple Music",
        subtitle: "Album"
    )

    static let spotifyAlbum = liveLink(
        urlString: spotifyAlbumURLString,
        kind: .spotify,
        title: "Spotify",
        subtitle: "Album"
    )

    static let tidalAlbum = liveLink(
        urlString: tidalAlbumURLString,
        kind: .tidal,
        title: "TIDAL",
        subtitle: "Album"
    )

    static let deezerAlbum = liveLink(
        urlString: deezerAlbumURLString,
        kind: .deezer,
        title: "Deezer",
        subtitle: "Album"
    )

    static let amazonMusicAlbum = liveLink(
        urlString: amazonMusicAlbumURLString,
        kind: .amazonMusic,
        title: "Amazon Music",
        subtitle: "Album"
    )

    static let bandcampAlbum = liveLink(
        urlString: bandcampAlbumURLString,
        kind: .bandcamp,
        title: "Bandcamp",
        subtitle: "Album"
    )

    static var primaryAppleMusic: PlatformLink {
        appleMusicAlbum ?? appleMusicArtist
    }

    static let allListen: [PlatformLink] = [
        appleMusicAlbum ?? appleMusicArtist,
        spotifyAlbum ?? spotifyArtist,
        youTubeMusicAlbum,
        soundCloudTrack,
        tidalAlbum,
        deezerAlbum,
        amazonMusicAlbum,
        bandcampAlbum
    ]
    .compactMap { $0 }

    static let widgetPlatforms: [PlatformLink] = [
        appleMusicAlbum ?? appleMusicArtist,
        spotifyAlbum ?? spotifyArtist,
        youTubeMusicAlbum
    ]

    static let artistLinks: [PlatformLink] = [
        appleMusicArtist,
        spotifyArtist,
        soundCloudArtist,
        youTube,
        x,
        facebook,
        github,
        suno,
        paypal
    ]

    private static func liveLink(
        urlString: String,
        kind: PlatformLink.Kind,
        title: String,
        subtitle: String
    ) -> PlatformLink? {
        guard !urlString.isEmpty, let webURL = URL(string: urlString) else {
            return nil
        }

        return PlatformLink(
            kind: kind,
            title: title,
            subtitle: subtitle,
            nativeURL: nil,
            webURL: webURL
        )
    }
}
