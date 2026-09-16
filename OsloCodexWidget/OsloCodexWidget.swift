import AppIntents
import SwiftUI
import WidgetKit

struct OsloCodexEntry: TimelineEntry {
    let date: Date
    let choice: TrackChoice
}

struct OsloCodexProvider: AppIntentTimelineProvider {
    typealias Entry = OsloCodexEntry
    typealias Intent = WidgetTrackIntent

    func placeholder(in context: Context) -> OsloCodexEntry {
        OsloCodexEntry(date: .now, choice: .osloCodex)
    }

    func snapshot(for configuration: WidgetTrackIntent, in context: Context) async -> OsloCodexEntry {
        OsloCodexEntry(date: .now, choice: configuration.track)
    }

    func timeline(for configuration: WidgetTrackIntent, in context: Context) async -> Timeline<OsloCodexEntry> {
        Timeline(entries: [OsloCodexEntry(date: .now, choice: configuration.track)], policy: .never)
    }
}

struct WidgetTrackIntent: WidgetConfigurationIntent {
    static let title: LocalizedStringResource = "Track"
    static let description = IntentDescription("Choose the default Oslo Codex shortcut.")

    @Parameter(title: "Track")
    var track: TrackChoice

    init() {
        self.track = .osloCodex
    }
}

struct OsloCodexWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    let entry: OsloCodexEntry

    private var track: Track {
        entry.choice.track
    }

    var body: some View {
        switch family {
        case .systemSmall:
            VStack(alignment: .leading, spacing: 12) {
                Image("OsloCodexCover")
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                Text("Listen")
                    .font(.headline)
                    .foregroundStyle(Palette.ink)
            }
            .widgetURL(URL(string: "oslocodex://listen"))
            .containerBackground(Palette.background, for: .widget)
        case .systemMedium:
            HStack(spacing: 14) {
                Image("OsloCodexCover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                VStack(alignment: .leading, spacing: 10) {
                    Text(track.title)
                        .font(.headline)
                        .foregroundStyle(Palette.ink)
                    Text("Jon Arve Ovesen")
                        .font(.subheadline)
                        .foregroundStyle(Palette.ice)
                    HStack {
                        ForEach(track.widgetPlatforms, id: \.id) { platform in
                            Link(platform.title, destination: platform.bestURL)
                        }
                    }
                    .font(.caption.bold())
                    .tint(Palette.neon)
                }
            }
            .containerBackground(Palette.background, for: .widget)
        case .accessoryCircular:
            ZStack {
                Circle().fill(Palette.background)
                Text("OC")
                    .font(.system(.caption, design: .rounded, weight: .bold))
                    .foregroundStyle(Palette.neon)
            }
            .widgetURL(URL(string: "oslocodex://listen"))
        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(track.title)
                    .font(.caption.bold())
                Text("Listen now")
                    .font(.caption2)
            }
            .foregroundStyle(Palette.ink)
            .widgetURL(URL(string: "oslocodex://listen"))
        default:
            Text(track.title)
                .widgetURL(URL(string: "oslocodex://track/\(track.slug)"))
        }
    }
}

struct OsloCodexWidget: Widget {
    let kind = "OsloCodexWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: WidgetTrackIntent.self, provider: OsloCodexProvider()) { entry in
            OsloCodexWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Oslo Codex")
        .description("Keep Oslo Codex one tap away.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular])
    }
}

@main
struct OsloCodexWidgetBundle: WidgetBundle {
    var body: some Widget {
        OsloCodexWidget()
    }
}
