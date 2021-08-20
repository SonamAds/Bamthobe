//
//  EditAddressVC.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire


class EditAddressVC: UIViewController {

    //MARK: - Variables
    var selectedTag = -1
    var pushModel: AddressDataModel?
//    var addressModel: AddressModel?
    var apiHelper = ApiHelper()
    var EDITADDRESS = "1"
    var DELETEADDRESS = "0"
    var userManager = UserManager.userManager
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
//    let locationManager = CLLocationManager()
    var currentCoordinate:CLLocationCoordinate2D?
    static var enable:Bool = true
    
    
    //MARK: - IBOutlets Properties
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var fullNamelbl:UITextField!
    @IBOutlet weak var addressLbl:UITextField!
    @IBOutlet weak var otherLbl:UITextField!
    @IBOutlet weak var otherLine:UIView!

    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var deleteAddressBtn:UIButton!
    @IBOutlet weak var savechangesBtn:UIButton!
    @IBOutlet weak var homeBtn:UIButton!
    @IBOutlet weak var otherBtn:UIButton!
    @IBOutlet weak var homeTickBtn:UIButton!
    @IBOutlet weak var otherTickBtn:UIButton!
    @IBOutlet weak var mapBtn:UIButton!
    @IBOutlet weak var mapView:UIView!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNamelbl.text = pushModel?.name
        addressLbl.text = pushModel?.address
        let mapTap1 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_Map))
        mapView.addGestureRecognizer(mapTap1)
        if pushModel?.home_type == "Home" || pushModel?.home_type == "home" {
            selectedTag = 0
//            otherLbl.text = pushModel?.home_type
//            otherLbl.isHidden = true
//            otherLine.isHidden = true
            homeTickBtn.isHidden = false
            otherTickBtn.isHidden = true
            homeBtn.backgroundColor = UIColor.black
            homeBtn.setTitleColor(UIColor.white, for: .normal)
            otherBtn.setTitleColor(UIColor.black, for: .normal)
            otherBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 241/255, a: 0.1)
        } else {
            selectedTag = 1
//            otherLbl.text = pushModel?.home_type
//            otherLbl.isHidden = false
//            otherLine.isHidden = false
            homeTickBtn.isHidden = true
            otherTickBtn.isHidden = false
            otherBtn.backgroundColor = UIColor.black
            otherBtn.setTitleColor(UIColor.white, for: .normal)
            homeBtn.setTitleColor(UIColor.black, for: .normal)
            homeBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 241/255, a: 0.1)
        }

        configureLocationServices()
//        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        map.showsUserLocation = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        map.showsUserLocation = false
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.PostData(urlString: KUpdateAddress, tag: EDITADDRESS, params: ["name":"\(fullNamelbl.text ?? "")","home_type":"\(selectedTag == 0 ? "Home" : "Work")","address":"\(addressLbl.text ?? "")", "address_id": "\(pushModel?.id ?? 0)"])
    }

    
    //MARK: - Location
//    func openMapForPlace() {
//
////        let lat1 : NSString = self.venueLat
////        let lng1 : NSString = self.venueLng
//
//        let latitude:CLLocationDegrees =  12.034//lat1.doubleValue
//        let longitude:CLLocationDegrees =  130.056//lng1.doubleValue
//
//        let regionDistance:CLLocationDistance = 10000
//        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "\(self.pushModel?.home_type)"
//        mapItem.openInMaps(launchOptions: options)
//
//    }
    
    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func btnTap_deleteAddress(_ sender: UIButton) {
        apiHelper.PostData(urlString: KDeleteAddress, tag: DELETEADDRESS, params: ["address_id": "\(pushModel?.id ?? 0)"])
    }

    @IBAction func btnTap_saveChanges(_ sender: UIButton) {
        if fullNamelbl.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Full Name", interval: 2)
        } else if addressLbl.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Enter Address", interval: 2)
        } else if selectedTag < 0 {
            SnackBar().showSnackBar(view: self.view, text: "Select Tag", interval: 2)
        } else {
            apiHit()
        }
    }

    @IBAction func btnTap_hometag(_ sender: UIButton) {
        selectedTag = 0
        otherLbl.isHidden = true
        otherLine.isHidden = true
        homeTickBtn.isHidden = false
        otherTickBtn.isHidden = true
        homeBtn.backgroundColor = UIColor.black
        homeBtn.setTitleColor(UIColor.white, for: .normal)
        otherBtn.setTitleColor(UIColor.black, for: .normal)
        otherBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 241/255, a: 0.1)
    }

    @IBAction func btnTap_otherTag(_ sender: UIButton) {
        selectedTag = 1
//        otherLbl.isHidden = false
//        otherLine.isHidden = false
        homeTickBtn.isHidden = true
        otherTickBtn.isHidden = false
        otherBtn.backgroundColor = UIColor.black
        otherBtn.setTitleColor(UIColor.white, for: .normal)
        homeBtn.setTitleColor(UIColor.black, for: .normal)
        homeBtn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 241/255, a: 0.1)
    }
    
    @IBAction func btnTap_Location(_ sender: UIButton) {
//        if CLLocationManager.locationServicesEnabled() {
//            if EditAddressVC.enable {
//                locationManager.stopUpdatingHeading()
//                configureLocationServices()
////                locationManager.delegate = self
//                sender.titleLabel?.text = "Enable"
////                getAddressFromLatLon(loc: )
//
//            }else{
//                locationManager.startUpdatingLocation()
//                configureLocationServices()
////                locationManager.delegate = self
//                sender.titleLabel?.text = "Disable"
//            }
//            EditAddressVC.enable = !EditAddressVC.enable
//        }
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

        let lat = Double(pushModel?.lat ?? "0.00")
        let lon = Double(pushModel?.lng ?? "0.00")
        center.latitude = lat ?? 0.00
        center.longitude = lon ?? 0.00
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.delegate = self
        if center == nil {
            vc.currentLocation = currentCoordinate
        } else if currentCoordinate == nil {
            vc.currentLocation = center
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gestureTap_Map() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        vc.delegate = self
        vc.currentLocation = currentCoordinate
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Convert Lat/Long Address
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
                    
                self.addressLbl.text = addressString
                print(addressString)
            }
        })
        currentCoordinate = center
    }
    
}


//MARK: - Custom Delegate
extension EditAddressVC: mapBackDelegate {
    func locSelected(address: String, currentLoc: CLLocationCoordinate2D) {
        addressLbl.text = address
        currentCoordinate = currentLoc
    }
    
}

//MARK: - UITextField Delegate
extension EditAddressVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == addressLbl {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapVC
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            //        vc.selectedPop = "Appointment"
            //        vc.modalPresentationStyle = .overCurrentContext
            //        vc.modalTransitionStyle = .crossDissolve
            //        vc.delegate = self
            //        self.present(vc, animated: true)
            return false
        }
        return true
    }
}


//MARK: - Map View
extension EditAddressVC: CLLocationManagerDelegate, MKMapViewDelegate {
    //MARK: - Custom Methods
    private func configureLocationServices() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdate(locationManager: locationManager)
        }

//        map.delegate = self
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
//        if let coor = map.userLocation.location?.coordinate{
//                mapView.setCenter(coor, animated: true)
//        }
    }

    private func beginLocationUpdate(locationManager: CLLocationManager) {
        map.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(zoomRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let identifier = "pin"
        var pview : MKPinAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            dequeueView.annotation = annotation
            pview = dequeueView
        } else {
//            pview.removeFromSuperview()
            pview = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pview.canShowCallout = false
//            pview.calloutOffset = CGPoint(x: -5, y: 5)
//            pview.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        pview.pinTintColor =  .red
        return pview
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")

        guard let latestLocation = locations.first else {
            return
        }
//        let lastLocation = locations.last!
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        currentCoordinate = latestLocation.coordinate
//        print("", currentCoordinate?.latitude)
//        print("", currentCoordinate?.longitude)

//        let annotation = MKPointAnnotation()
//        annotation.coordinate = currentCoordinate!
////            annotation.title = "Javed Multani"
//        annotation.subtitle = "current location"
//        mapView.addAnnotation(annotation)


//        getAddressFromLatLon(/*pdblLatitude: (currentCoordinate?.latitude), withLongitude: (currentCoordinate?.longitude)*/loc: currentCoordinate!)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("the status changed")

        if status == .authorizedAlways || status == .authorizedWhenInUse {
            beginLocationUpdate(locationManager: manager)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       if let error = error as? CLError, error.code == .denied {
          // Location updates are not authorized.
          manager.stopMonitoringSignificantLocationChanges()
          return
       }
       // Notify the user of any errors.
    }
}

//extension EditAddressVC: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager,
//                         didChangeAuthorization status: CLAuthorizationStatus) {
//
//        if status == .authorizedWhenInUse || status == .authorizedAlways {
//            locationManager.startUpdatingLocation()
//        }
//    }
//}



//MARk: - API Success
extension EditAddressVC: ApiResponseDelegate{
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case EDITADDRESS:
                do{
                    print(responseData)
                    
                    let response = try jsonDecoder.decode(LoginModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                    // create session here
                        navigationController?.popViewController(animated: true)
                        
                    } else if response.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            case DELETEADDRESS:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(SuccessModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                        // create session here
                        navigationController?.popViewController(animated: true)
                    
                    } else if response.status == false {
                        LoadingIndicatorView.hide()
                        SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
            default:
                break
            }
        }


    func onFailure(msg: String) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(msg)", interval: 4)
    }

       func onError(error: AFError) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(error)", interval: 4)
    }


}
