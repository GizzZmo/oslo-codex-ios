import CoreLocation
import Foundation

struct Album: Sendable {
    let title: String
    let artist: String
    let imprint: String
    let year: Int
    let genres: [String]
    let taglineEN: String
    let taglineNB: String
    let aboutEN: String
    let aboutNB: String
    let tracks: [Track]
    let places: [Place]

    init(
        title: String,
        artist: String,
        imprint: String,
        year: Int,
        genres: [String],
        taglineEN: String,
        taglineNB: String,
        aboutEN: String,
        aboutNB: String,
        tracks: [Track],
        places: [Place]
    ) {
        precondition(!tracks.isEmpty, "Album.tracks must never be empty.")
        self.title = title
        self.artist = artist
        self.imprint = imprint
        self.year = year
        self.genres = genres
        self.taglineEN = taglineEN
        self.taglineNB = taglineNB
        self.aboutEN = aboutEN
        self.aboutNB = aboutNB
        self.tracks = tracks
        self.places = places
    }

    var listenPlatforms: [PlatformLink] {
        PlatformLinks.allListen
    }

    var bestShareURL: URL {
        PlatformLinks.canonicalShareURL
    }

    var shareText: String {
        """
        Oslo Codex — Jon Arve Ovesen
        Nordic rap noir from the capital.
        \(bestShareURL.absoluteString)
        \(PlatformLinks.hashtags.joined(separator: " "))
        """
    }

    var localizedTagline: String {
        Locale.current.language.languageCode?.identifier == "nb" ? taglineNB : taglineEN
    }

    var localizedAbout: String {
        Locale.current.language.languageCode?.identifier == "nb" ? aboutNB : aboutEN
    }

    func track(slug: String) -> Track? {
        tracks.first { $0.slug == slug }
    }

    static let current = Album(
        title: "Oslo Codex",
        artist: "Jon Arve Ovesen",
        imprint: "Cybergroup Incorporated",
        year: 2025,
        genres: ["Nordic Rap Noir", "Hip-Hop", "R&B"],
        taglineEN: "The sound of the North. Calculated. Cold. Heart still warm.",
        taglineNB: "Lyden av nord. Kalkulert. Kald. Hjertet er varmt.",
        aboutEN: "Oslo Codex is a cinematic Nordic rap-noir record: winter weight on Karl Johan, Akerselva's dark rhythmic glow, lab ozone and pine, MPC as a vault clock. 90s G-Funk sub-bass, soulful synth leads, precise technical rap, high-fidelity polish. Oslo city, stand up.",
        aboutNB: "Oslo Codex er et filmatisk nordisk rap-noir-album: vintertyngde over Karl Johan, Akerselvas mørke rytmiske glød, lukt av labb, ozon og furu, og en MPC som slår som et hvelvur. 90-talls G-funk-bass, sjelfulle synthlinjer, presis rap og høyglanset produksjon. Oslo by, reis deg.",
        tracks: [
            Track(
                index: 1,
                title: "Oslo Codex",
                slug: "oslo-codex",
                duration: "—",
                isExplicit: false,
                credits: Credits(
                    writer: "Jon Arve Ovesen",
                    producer: "Jon-Arve Constantine Gronsberg-Ovesen"
                ),
                lyricResourceName: "oslo-codex",
                platforms: [PlatformLinks.youTubeMusicAlbum, PlatformLinks.soundCloudTrack]
            )
        ],
        places: [
            Place(title: "Karl Johans gate", noteEN: "Verse geography", noteNB: "Versgeografi", quote: "Karl Johan", latitude: 59.9133, longitude: 10.7389),
            Place(title: "Akerselva", noteEN: "Dark rhythmic glow", noteNB: "Mørk rytmisk glød", quote: "Akerselva", latitude: 59.9180, longitude: 10.7520),
            Place(title: "MUNCH", noteEN: "Museum shadows", noteNB: "Museets skygger", quote: "MUNCH", latitude: 59.9050, longitude: 10.7550),
            Place(title: "Oslo S", noteEN: "Arrival", noteNB: "Ankomst", quote: "Oslo S", latitude: 59.9111, longitude: 10.7528),
            Place(title: "Ekeberg / city view", noteEN: "Capital at night", noteNB: "Hovedstaden om natten", quote: "Ekeberg", latitude: 59.9000, longitude: 10.7680)
        ]
    )
}

struct Track: Identifiable, Hashable, Sendable {
    let index: Int
    let title: String
    let slug: String
    let duration: String
    let isExplicit: Bool
    let credits: Credits
    let lyricResourceName: String
    let platforms: [PlatformLink]

    var id: String { slug }

    var shareText: String {
        """
        \(title) — \(Album.current.artist)
        \(Album.current.bestShareURL.absoluteString)
        \(PlatformLinks.hashtags.joined(separator: " "))
        """
    }
}

struct Credits: Hashable, Sendable {
    let writer: String
    let producer: String
}

struct Place: Identifiable, Hashable, Sendable {
    let title: String
    let noteEN: String
    let noteNB: String
    let quote: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees

    var id: String { title }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var localizedNote: String {
        Locale.current.language.languageCode?.identifier == "nb" ? noteNB : noteEN
    }
}
