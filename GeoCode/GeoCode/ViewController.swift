//
//  ViewController.swift
//  GeoCode
//
//  Created by MMan on 11/9/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var myMap: MKMapView!
    // CLLocationManager *locationManager;
    var locationManager: CLLocationManager?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager?.distanceFilter = kCLDistanceFilterNone
        print("Authorization Status \(CLLocationManager.authorizationStatus())")
        if self.locationManager?.responds(to: #selector(self.requestWhenInUseAuthorization)) {
            //Must have NSLocationWhenInUsageDescription set to a string in Info.plist for iOS to pop up permission request window
            self.locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.startUpdatingLocation()
        locationManager?.startUpdatingHeading()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var geocoder = CLGeocoder()
        //May get several updates in an array - we will use first only
        print("location object \(locations[0])")
        var myLoc: CLLocation? = (locations[0] as? CLLocation)
        if locations.count > 0 {
            //Let's get the last object
            myLoc = locations.last
            var newLocation = CLLocation(latitude: (myLoc?.coordinate.latitude)!, longitude: (myLoc?.coordinate.longitude)!)
            geocoder.reverseGeocodeLocation(newLocation, completionHandler: {(_ placemarks: [Any], _ err: Error) -> Void in
                if placemarks.count {
                    print("------ Start of Info for Placemark \(placemarks.count)")
                    print("Name = \(placemarks[0].name)")
                    print("subThoroughFare = \(placemarks[0].subThoroughfare)")
                    print("Thoroughfare = \(placemarks[0].thoroughfare)")
                    print("subLocality = \(placemarks[0].subLocality)")
                    print("Locality = \(placemarks[0].locality)")
                    print("subAdministrativeArea = \(placemarks[0].subAdministrativeArea)")
                    print("AdministrativeArea = \(placemarks[0].administrativeArea)")
                    print("postalCode = \(placemarks[0].postalCode)")
                    print("Country = \(placemarks[0].country)")
                    print("ISOCountryCode = \(placemarks[0].isOcountryCode)")
                    print("inlandwater = \(placemarks[0].inlandWater)")
                    print("Ocean = \(placemarks[0].ocean)")
                    print("------ End of Info for Placemark \(placemarks.count)")
                    //to get object description you could do [placemarks[0] description];
                }
            })
        }
            //set span and region
        var span: MKCoordinateSpan = MKCoordinateSpanMake(0.009, 0.009)
        var region: MKCoordinateRegion? = MKCoordinateRegionMake((myLoc?.coordinate)!, span)
        myMap.setRegion(region!, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("DidChangeAuthorizationStatus Method Called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
    }
}
