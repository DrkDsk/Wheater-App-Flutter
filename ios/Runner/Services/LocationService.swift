import CoreLocation

class LocationService:
    NSObject,
    CLLocationManagerDelegate {

    private let manager =
        CLLocationManager()
    
    private var onRequestPermission: FlutterResult?
    
    private var onSuccess:
    ((CLLocation) -> Void)?
    
    private var onError:
    (() -> Void)?

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        onError?()
    }
    
    func getCurrentLocation(
            onSuccess:
            @escaping (CLLocation) -> Void,

            onError:
            @escaping () -> Void
        ) {

            self.onSuccess = onSuccess
            self.onError = onError

            manager.requestWhenInUseAuthorization()

            manager.requestLocation()
        }

    func startUpdatingLocation(
        onUpdate:
        @escaping (CLLocation) -> Void
    ) {

        self.onSuccess = onUpdate

        manager.requestWhenInUseAuthorization()

        manager.startUpdatingLocation()
    }

    func stopUpdating() {
        manager.stopUpdatingLocation()
    }
    
    func requestPermission(result: @escaping FlutterResult) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            result(true)
            return
        
        case .denied, .restricted:
            result(false)
            return
            
        case .notDetermined:
            onRequestPermission = result
            manager.requestWhenInUseAuthorization()
            
        @unknown default:
            result(false)
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations:
        [CLLocation]
    ) {

        guard let location =
            locations.last else {
            return
        }

        onSuccess?(location)
    }
}
