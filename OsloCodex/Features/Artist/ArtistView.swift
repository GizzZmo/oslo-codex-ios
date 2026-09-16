import SwiftUI

struct ArtistView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 16) {
                        Image("OsloCodexCover")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 108, height: 108)
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))

                        VStack(alignment: .leading, spacing: 8) {
                            Text(Album.current.artist)
                                .font(.title.bold())
                                .foregroundStyle(Palette.ink)
                            Text("Cybergroup Incorporated")
                                .foregroundStyle(Palette.ice)
                            Text("Eidsvoll / Oslo")
                                .foregroundStyle(Palette.muted)
                        }
                    }

                    Text(String(localized: "artist_bio"))
                        .foregroundStyle(Palette.ink)

                    VStack(alignment: .leading, spacing: 12) {
                        Text(String(localized: "discography_title"))
                            .font(.title3.bold())
                            .foregroundStyle(Palette.ink)
                        ViewThatFits(in: .horizontal) {
                            HStack(spacing: 12) {
                                Link(destination: PlatformLinks.appleMusicArtist.bestURL) {
                                    Label("Apple Music", systemImage: "music.note")
                                }
                                .buttonStyle(GlassButtonStyle())

                                Link(destination: PlatformLinks.spotifyArtist.bestURL) {
                                    Label("Spotify", systemImage: "waveform")
                                }
                                .buttonStyle(GlassButtonStyle())
                            }

                            VStack(alignment: .leading, spacing: 12) {
                                Link(destination: PlatformLinks.appleMusicArtist.bestURL) {
                                    Label("Apple Music", systemImage: "music.note")
                                }
                                .buttonStyle(GlassButtonStyle())

                                Link(destination: PlatformLinks.spotifyArtist.bestURL) {
                                    Label("Spotify", systemImage: "waveform")
                                }
                                .buttonStyle(GlassButtonStyle())
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(String(localized: "links_title"))
                            .font(.title3.bold())
                            .foregroundStyle(Palette.ink)

                        ForEach(PlatformLinks.artistLinks) { platform in
                            Link(destination: platform.bestURL) {
                                PlatformTile(platform: platform)
                            }
                        }
                    }
                }
                .padding(20)
            }
            .background(Palette.background.ignoresSafeArea())
            .navigationTitle(String(localized: "tab_artist"))
        }
    }
}
