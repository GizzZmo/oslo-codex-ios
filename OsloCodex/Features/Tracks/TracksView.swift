import SwiftUI

struct TracksView: View {
    @Bindable var router: AppRouter

    var body: some View {
        NavigationStack {
            List {
                ForEach(Album.current.tracks) { track in
                    Button {
                        router.selectedTrack = track
                    } label: {
                        HStack(spacing: 16) {
                            Text(track.index.formatted(.number.precision(.integerLength(2))))
                                .font(.headline.monospacedDigit())
                                .foregroundStyle(Palette.neon)
                            VStack(alignment: .leading, spacing: 4) {
                                Text(track.title)
                                    .foregroundStyle(Palette.ink)
                                Text(track.duration)
                                    .font(.subheadline)
                                    .foregroundStyle(Palette.muted)
                            }
                            Spacer()
                            if track.isExplicit {
                                Text("E")
                                    .font(.caption.bold())
                                    .padding(6)
                                    .background(Palette.warn, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                                    .accessibilityLabel(String(localized: "explicit_badge"))
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Palette.backgroundElevated)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Palette.background.ignoresSafeArea())
            .navigationTitle(String(localized: "tracks_section"))
            .navigationDestination(item: $router.selectedTrack) { track in
                TrackDetailView(track: track)
            }
        }
    }
}
