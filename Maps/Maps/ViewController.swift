//  ViewController.swift
//  Maps
//
//  Created by MMan on 11/9/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import MapKit
import UIKit
class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var myMap: MKMapView!

    @IBAction func apple(_ sender: Any) {
        var coords: CLLocationCoordinate2D
        coords.latitude = 37.33188
        coords.longitude = -122.029497
        var span: MKCoordinateSpan = MKCoordinateSpanMake(0.002389, 0.005681)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(coords, span)
        myMap.setRegion(region, animated: true)
    }

    @IBAction func changeMapType(_ sender: Any) {
        var control: UISegmentedControl? = (sender as? UISegmentedControl)
        self.myMap.mapType = MKMapType(rawValue: UInt(control!.selectedSegmentIndex))!
    }


    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        var geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("2211 Comstock Lane, Naperville, IL, United States", completionHandler: {(_ placemarks: [Any], _ err: Error?) -> Void in
            for aPlaceMark: CLPlacemark in placemarks {
                var lat = String(format: "%.4f", aPlaceMark.location.coordinate.latitude)
                var lon = String(format: "%.4f", aPlaceMark.location.coordinate.longitude)
                print(" lat is \(lat), long is \(lon)")
    
                var coords1: CLLocationCoordinate2D
                coords1.latitude = aPlaceMark.location.coordinate.latitude
                coords1.longitude = aPlaceMark.location.coordinate.longitude
                var span1: MKCoordinateSpan = MKCoordinateSpanMake(0.002389, 0.005681)
                var region1: MKCoordinateRegion = MKCoordinateRegionMake(coords1, span1)
                self.myMap.setRegion(region1, animated: true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
