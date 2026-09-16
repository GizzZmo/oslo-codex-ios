import AppIntents

enum TrackChoice: String, AppEnum, CaseIterable {
    case osloCodex

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Track")
    static var caseDisplayRepresentations: [TrackChoice: DisplayRepresentation] = [
        .osloCodex: DisplayRepresentation(title: "Oslo Codex")
    ]

    var track: Track {
        Album.current.tracks[0]
    }
}
