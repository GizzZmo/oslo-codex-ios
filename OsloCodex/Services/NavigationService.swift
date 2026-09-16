import CoreLocation
import UIKit

@MainActor
final class NavigationService: NSObject, CLLocationManagerDelegate {
    static let shared = NavigationService()

    private let locationManager = CLLocationManager()
    private var pendingURL: URL?

    private override init() {
        super.init()
        locationManager.delegate = self
    }

    func navigate(to url: URL) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            pendingURL = url
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse, .denied, .restricted:
            UIApplication.shared.open(url)
        @unknown default:
            UIApplication.shared.open(url)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let pendingURL else { return }

        switch manager.authorizationStatus {
        case .notDetermined:
            return
        case .authorizedAlways, .authorizedWhenInUse, .denied, .restricted:
            self.pendingURL = nil
            UIApplication.shared.open(pendingURL)
        @unknown default:
            self.pendingURL = nil
            UIApplication.shared.open(pendingURL)
        }
    }
}
