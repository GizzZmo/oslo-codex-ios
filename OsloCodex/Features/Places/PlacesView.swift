import MapKit
import SwiftUI

struct PlacesView: View {
    @Bindable var router: AppRouter
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 59.9115, longitude: 10.7514),
            span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        )
    )

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Map(position: $cameraPosition) {
                    ForEach(Album.current.places) { place in
                        Annotation(place.title, coordinate: place.coordinate) {
                            Circle()
                                .fill(Palette.neon)
                                .frame(width: 16, height: 16)
                                .overlay(
                                    Circle().stroke(Palette.ice, lineWidth: 2)
                                )
                                .shadow(color: Palette.neon.opacity(0.8), radius: 12)
                        }
                    }
                }
                .mapStyle(.standard(elevation: .flat, emphasis: .muted))
                .environment(\.colorScheme, .dark)
                .ignoresSafeArea()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Album.current.places) { place in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(place.title)
                                    .font(.headline)
                                    .foregroundStyle(Palette.ink)
                                Text(place.localizedNote)
                                    .font(.subheadline)
                                    .foregroundStyle(Palette.muted)
                                HStack {
                                    Button(String(localized: "listen_here")) {
                                        router.isListenSheetPresented = true
                                    }
                                    .buttonStyle(GlassButtonStyle())

                                    Link(destination: mapsURL(for: place)) {
                                        Label(String(localized: "navigate"), systemImage: "location")
                                    }
                                    .buttonStyle(GlassButtonStyle())
                                }
                            }
                            .padding(18)
                            .frame(width: 280, alignment: .leading)
                            .background(Palette.backgroundElevated.opacity(0.9), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .glassEffect()
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(String(localized: "places_section"))
        }
    }

    private func mapsURL(for place: Place) -> URL {
        var components = URLComponents(string: "https://maps.apple.com/")!
        components.queryItems = [
            URLQueryItem(name: "ll", value: "\(place.latitude),\(place.longitude)"),
            URLQueryItem(name: "q", value: place.title)
        ]
        return components.url!
    }
}
