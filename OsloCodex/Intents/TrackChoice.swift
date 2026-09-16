import AppIntents

enum TrackChoice: String, AppEnum, CaseIterable {
    case osloCodex

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Track")
    static var caseDisplayRepresentations: [TrackChoice: DisplayRepresentation] = [
        .osloCodex: DisplayRepresentation(title: "Oslo Codex")
    ]

    var track: Track {
        switch self {
        case .osloCodex:
            Album.current.track(slug: "oslo-codex") ?? Album.current.tracks[0]
        }
    }
}
