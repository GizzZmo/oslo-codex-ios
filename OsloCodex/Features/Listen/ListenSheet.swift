import SwiftUI

struct ListenSheet: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    let platforms: [PlatformLink]

    private var columns: [GridItem] {
        dynamicTypeSize.isAccessibilitySize
            ? [GridItem(.flexible())]
            : [GridItem(.flexible()), GridItem(.flexible())]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(String(localized: "listen_sheet_title"))
                        .font(.largeTitle.bold())
                        .foregroundStyle(Palette.ink)

                    Text(String(localized: "listen_sheet_subtitle"))
                        .font(.body)
                        .foregroundStyle(Palette.muted)

                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(platforms) { platform in
                            Button {
                                Task {
                                    await LinkOpener.shared.open(platform: platform)
                                }
                            } label: {
                                PlatformTile(platform: platform)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("\(String(localized: "open_in")) \(platform.title)")
                        }
                    }

                    ShareLink(item: Album.current.shareText) {
                        Label(String(localized: "share_album"), systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(GlassButtonStyle())
                    .padding(.top, 8)
                }
                .padding(20)
            }
            .background(Palette.background.ignoresSafeArea())
        }
    }
}
