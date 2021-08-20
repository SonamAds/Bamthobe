//
//  MapVC.swift
//  Bam
//
//  Created by ADS N URL on 30/06/21.
//

import UIKit
import MapKit
import CoreLocation


protocol mapBackDelegate {
    func locSelected(address: String, currentLoc: CLLocationCoordinate2D)
}


class MapVC: UIViewController {
    
    //MARK: - Variables
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D?
    static var enable:Bool = true
    var delegate: mapBackDelegate?
    
    
    //MARK: - IBOutlets Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        if currentLocation != nil {
            getAddressFromLatLon(loc: currentLocation!)
        }
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        addLongPressGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mapView.showsUserLocation = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.showsUserLocation = false
    }
    
    
    //MARK: - Custom Method
    func addLongPressGesture(){
        let longPressRecogniser:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target:self , action:#selector(MapVC.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 1.0 //user needs to press for 2 seconds
        self.mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    
    func resetTracking(){
        if (mapView.showsUserLocation){
            mapView.showsUserLocation = false
            self.mapView.removeAnnotations(mapView.annotations)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func centerMap(_ center:CLLocationCoordinate2D){
//        self.saveCurrentLocation(center)
        getAddressFromLatLon(loc: center)
        let spanX = 0.007
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center: center, latitudinalMeters: spanX, longitudinalMeters: spanY)
        mapView.setRegion(newRegion, animated: true)
    }
    
//    func saveCurrentLocation(_ center:CLLocationCoordinate2D){
//        let message = "\(center.latitude) , \(center.longitude)"
//        print(message)
//        self.addressTF.text = message
//        currentLocation = center
//    }
    
    func getAddressFromLatLon(/*pdblLatitude: CLL, withLongitude pdblLongitude: String*/loc: CLLocationCoordinate2D) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat = loc.latitude
        let lon = loc.longitude
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            if (error != nil) {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
                    
            if pm.count > 0 {
                let pm = placemarks![0]
                print(pm.country)
                print(pm.locality)
                print(pm.subLocality)
                print(pm.thoroughfare)
                print(pm.postalCode)
                print(pm.subThoroughfare)
                var addressString : String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                    
                self.addressTF.text = addressString
                print(addressString)
            }
        })
        currentLocation = center
    }
    
    
    //MARK: - IBAction
    @objc func handleLongPress(_ gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state != .began{
            return
        }
        
        let touchPoint:CGPoint = gestureRecognizer.location(in: self.mapView)
        let touchMapCoordinate:CLLocationCoordinate2D =
            self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        let annot:MKPointAnnotation = MKPointAnnotation()
        annot.coordinate = touchMapCoordinate
        
        self.resetTracking()
        self.mapView.addAnnotation(annot)
        self.centerMap(touchMapCoordinate)
    }
    
}
    
extension MapVC: CLLocationManagerDelegate,MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        centerMap(locValue)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "pin"
        var view : MKPinAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        view.pinColor =  .red
        return view
    }
    
    @IBAction func getMyLocation(_ sender: UIButton) {
        
        if CLLocationManager.locationServicesEnabled() {
            if MapVC.enable {
                locationManager.stopUpdatingHeading()
                sender.titleLabel?.text = "Enable"
            }else{
                locationManager.startUpdatingLocation()
                sender.titleLabel?.text = "Disable"
            }
            MapVC.enable = !MapVC.enable
        }
    }
    
    @IBAction func closePressed(sender: UIButton) {
        if addressTF.text != "" {
//            self.dismiss(animated: true, completion: {(
                self.delegate?.locSelected(address: self.addressTF.text ?? "", currentLoc: self.currentLocation!)
//            )})
        self.navigationController?.popViewController(animated: true)
        } else {
            SnackBar().showSnackBar(view: self.view, text: "Select Address", interval: 2)
        }
    }
    
}


////
//class MapVC: UIViewController {
//
//    private let locationManager = CLLocationManager()
//    private var currentCoordinate: CLLocationCoordinate2D?
////    var place: InterestingPlace?
//
//
//    //  MARK:- IBOutlets
//    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var addressTF: UITextField!
//    @IBOutlet weak var closeBtn: UIButton!
//
//
//    // MARK:- View Life Cycle
//    override func viewDidLoad() {
//    super.viewDidLoad()
//        configureLocationServices()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        mapView.showsUserLocation = true;
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        mapView.showsUserLocation = false
//    }
//
//
//    //MARK: - IBActions
//    @IBAction func closePressed(sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//
//    //MARK: - Custom Methods
//    private func configureLocationServices() {
//        locationManager.delegate = self
//        let status = CLLocationManager.authorizationStatus()
//        if status == .notDetermined {
//            locationManager.requestAlwaysAuthorization()
//        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
//            beginLocationUpdate(locationManager: locationManager)
//        }
//
//        mapView.delegate = self
//        mapView.mapType = .standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//        if let coor = mapView.userLocation.location?.coordinate{
//                mapView.setCenter(coor, animated: true)
//        }
//        addLongPressGesture()
//    }
//
//    private func beginLocationUpdate(locationManager: CLLocationManager) {
//        mapView.showsUserLocation = true
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//    }
//
//    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
//        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        mapView.setRegion(zoomRegion, animated: true)
//    }
//
//    func startMySignificantLocationChanges() {
//        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
//            // The device does not support this service.
//            return
//        }
//        locationManager.startMonitoringSignificantLocationChanges()
//    }
//
////    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
////                    -> Void ) {
////        // Use the last reported location.
////        if let lastLocation = self.locationManager.location {
////            let geocoder = CLGeocoder()
////
////            // Look up the location and pass it to the completion handler
////            geocoder.reverseGeocodeLocation(lastLocation,
////                        completionHandler: { (placemarks, error) in
////                if error == nil {
////                    let firstLocation = placemarks?[0]
////                    addressTF.text = firstLocation
////                    completionHandler(firstLocation)
////
////                }
////                else {
////                 // An error occurred during geocoding.
////                    completionHandler(nil)
////                }
////            })
////        }
////        else {
////            // No location was available.
////            completionHandler(nil)
////        }
////    }
//
////    func getCoordinate( addressString : String,
////            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
////        let geocoder = CLGeocoder()
////        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
////            if error == nil {
////                if let placemark = placemarks?[0] {
////                    let location = placemark.location!
////
////                    completionHandler(location.coordinate, nil)
////                    return
////                }
////            }
////
////            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
////        }
////    }
//
//
//    func getAddressFromLatLon(/*pdblLatitude: CLL, withLongitude pdblLongitude: String*/loc: CLLocationCoordinate2D) {
//            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
////            let lat: Double = Double("\(pdblLatitude)")!
////            //21.228124
////            let lon: Double = Double("\(pdblLongitude)")!
//           //// 72.833770
//        let lat = loc.latitude
//        let lon = loc.longitude
//            let ceo: CLGeocoder = CLGeocoder()
//            center.latitude = lat
//            center.longitude = lon
//
//            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
//
//
//            ceo.reverseGeocodeLocation(loc, completionHandler:
//                {(placemarks, error) in
//                    if (error != nil)
//                    {
//                        print("reverse geodcode fail: \(error!.localizedDescription)")
//                    }
//                    let pm = placemarks! as [CLPlacemark]
//
//                    if pm.count > 0 {
//                        let pm = placemarks![0]
//                        print(pm.country)
//                        print(pm.locality)
//                        print(pm.subLocality)
//                        print(pm.thoroughfare)
//                        print(pm.postalCode)
//                        print(pm.subThoroughfare)
//                        var addressString : String = ""
//                        if pm.subLocality != nil {
//                            addressString = addressString + pm.subLocality! + ", "
//                        }
//                        if pm.thoroughfare != nil {
//                            addressString = addressString + pm.thoroughfare! + ", "
//                        }
//                        if pm.locality != nil {
//                            addressString = addressString + pm.locality! + ", "
//                        }
//                        if pm.country != nil {
//                            addressString = addressString + pm.country! + ", "
//                        }
//                        if pm.postalCode != nil {
//                            addressString = addressString + pm.postalCode! + " "
//                        }
//
//
//                        print(addressString)
//                  }
//            })
//
//        }
//
//}
//
//extension MapVC: CLLocationManagerDelegate, MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
//        let identifier = "pin"
//        var pview : MKPinAnnotationView
//        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
//            dequeueView.annotation = annotation
//            pview = dequeueView
//        }else{
////            pview.removeFromSuperview()
//            pview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            pview.canShowCallout = false
////            pview.calloutOffset = CGPoint(x: -5, y: 5)
////            pview.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        pview.pinTintColor =  .red
//        return pview
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("Did get latest location")
//
//        guard let latestLocation = locations.first else {
//            return
//        }
////        let lastLocation = locations.last!
//        if currentCoordinate == nil {
//            zoomToLatestLocation(with: latestLocation.coordinate)
//        }
//        currentCoordinate = latestLocation.coordinate
////        print("", currentCoordinate?.latitude)
////        print("", currentCoordinate?.longitude)
//
////        startMySignificantLocationChanges()
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = currentCoordinate!
//////            annotation.title = "Javed Multani"
////        annotation.subtitle = "current location"
////        mapView.addAnnotation(annotation)
//
//
//        getAddressFromLatLon(/*pdblLatitude: (currentCoordinate?.latitude), withLongitude: (currentCoordinate?.longitude)*/loc: currentCoordinate!)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("the status changed")
//
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            beginLocationUpdate(locationManager: manager)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//       if let error = error as? CLError, error.code == .denied {
//          // Location updates are not authorized.
//          manager.stopMonitoringSignificantLocationChanges()
//          return
//       }
//       // Notify the user of any errors.
//    }
//}
//
//    // MARK:- Variables
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var searchController: UISearchController?
//    var locationManager: CLLocationManager!
//    var currentLocation: CLLocation?
//    var gmsmapView: GMSMapView!
//    var placesClient: GMSPlacesClient!
//    var preciseLocationZoomLevel: Float = 15.0
//    var approximateLocationZoomLevel: Float = 10.0
//    // The currently selected place.
//    var selectedPlace: GMSPlace?
//
//    let mapcamera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
////    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//
//    // MARK:- IBOutlets
////    @IBOutlet weak var mapView: MKMapView!
//    @IBOutlet weak var headingLbl: UILabel!
//    @IBOutlet weak var fullNamelbl:UITextField!
//    @IBOutlet weak var addressLbl:UITextField!
//    @IBOutlet weak var otherLbl:UITextField!
//    @IBOutlet weak var otherLine:UIView!
//
//
//    // MARK:- View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        mapView.camera = mapcamera
//        // Initialize the location manager.
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//
//        placesClient = GMSPlacesClient.shared()
////        setupSearchController()
////        resultsViewController?.delegate = self
//        if #available(iOS 14.0, *) {
//            initialLoad()
//        } else {
//            // Fallback on earlier versions
//        }
////        loadView()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//
////    override func loadView() {
////        let marker = GMSMarker()
////        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
////        marker.title = "Sydney"
////        marker.snippet = "Australia"
////        marker.map = mapView
////    }
//    func setupSearchController() {
//           resultsViewController = GMSAutocompleteResultsViewController()
//           searchController = UISearchController(searchResultsController: resultsViewController)
//           searchController?.searchResultsUpdater = resultsViewController
//
//           let searchBar = searchController!.searchBar
//           searchBar.sizeToFit()
//           searchBar.placeholder = "Search for places"
//           navigationItem.titleView = searchController?.searchBar
//           definesPresentationContext = true
//           searchController?.hidesNavigationBarDuringPresentation = false
//       }
//
//    @available(iOS 14.0, *)
//    func initialLoad() {
//        // A default location to use when location permission is not granted.
//        let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
//
//        // Create a map.
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
//        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
//                                              longitude: defaultLocation.coordinate.longitude,
//                                              zoom: zoomLevel)
//        gmsmapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
//        gmsmapView.settings.myLocationButton = true
//        gmsmapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        gmsmapView.isMyLocationEnabled = true
//
//        // Add the map to the view, hide it until we've got a location update.
//        view.addSubview(gmsmapView)
//        gmsmapView.isHidden = true
//    }
//
//
//    //MARK: Actions
//    // Update the map once the user has made their selection.
//    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
//      // Clear the map.
//      gmsmapView.clear()
//
//      // Add a marker to the map.
//      if let place = selectedPlace {
//        let marker = GMSMarker(position: place.coordinate)
//        marker.title = selectedPlace?.name
//        marker.snippet = selectedPlace?.formattedAddress
//        marker.map = gmsmapView
//      }
//
//    }
//    @IBAction func btnTap_back(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
//    }
//
//}
//
//
////extension MapVC: GMSAutocompleteResultsViewControllerDelegate {
////    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
////        print("Error: \(error.localizedDescription)")
////    }
////
////    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
////        // 1
////        searchController?.isActive = false
////
////        // 2
////        mapView.removeAnnotations(mapView.annotations)
////
////        // 3
////        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
////        let region = MKCoordinateRegion(center: place.coordinate, span: span)
////        mapView.setRegion(region, animated: true)
////
////        // 4
////        let annotation = MKPointAnnotation()
////        annotation.coordinate = place.coordinate
////        annotation.title = place.name
////        annotation.subtitle = place.formattedAddress
////        mapView.addAnnotation(annotation)
////    }
////
////
////}
//
//// Delegates to handle events for the location manager.
//extension MapVC: CLLocationManagerDelegate {
//
//  // Handle incoming location events.
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    let location: CLLocation = locations.last!
//    print("Location: \(location)")
//
//    if #available(iOS 14.0, *) {
//        let zoomLevel = locationManager.accuracyAuthorization == .fullAccuracy ? preciseLocationZoomLevel : approximateLocationZoomLevel
//        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                              longitude: location.coordinate.longitude,
//                                              zoom: zoomLevel)
//        if gmsmapView.isHidden {
//            gmsmapView.isHidden = false
//            gmsmapView.camera = camera
//        } else {
//            gmsmapView.animate(to: camera)
//        }
//    } else {
//        // Fallback on earlier versions
//    }
//
//  }
//
//  // Handle authorization for the location manager.
//  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    // Check accuracy authorization
//    if #available(iOS 14.0, *) {
//        let accuracy = manager.accuracyAuthorization
//        switch accuracy {
//        case .fullAccuracy:
//            print("Location accuracy is precise.")
//        case .reducedAccuracy:
//            print("Location accuracy is not precise.")
//        @unknown default:
//          fatalError()
//        }
//    } else {
//        // Fallback on earlier versions
//    }
//
//
//    // Handle authorization status
//    switch status {
//    case .restricted:
//      print("Location access was restricted.")
//    case .denied:
//      print("User denied access to location.")
//      // Display the map using the default location.
//      gmsmapView.isHidden = false
//    case .notDetermined:
//      print("Location status not determined.")
//    case .authorizedAlways: fallthrough
//    case .authorizedWhenInUse:
//      print("Location status is OK.")
//    @unknown default:
//      fatalError()
//    }
//  }
//
//  // Handle location manager errors.
//  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//    locationManager.stopUpdatingLocation()
//    print("Error: \(error)")
//  }
//}
