import UIKit
import MapKit
import CoreLocation

class ServiceMapViewController: UIViewController {
    @IBOutlet private weak var mapView: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        default:
            break
        }
        
        locationManager.requestLocation()
    }
    
    private func addMarker(title: String, coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
}

extension ServiceMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 53.893009, longitude: 27.567444),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            mapView.setRegion(region, animated: true)
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Автосервис"
            request.region = mapView.region
            let search = MKLocalSearch(request: request)
            search.start {
                response,
                _ in
                guard let response = response else { return }
                
                response.mapItems.forEach { [weak self] item in
                    self?.addMarker(
                        title: item.name ?? "",
                        coordinate: item.placemark.coordinate
                    )
                }
            }
        }
    }
}
