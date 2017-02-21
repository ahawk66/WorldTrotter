//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Hawkins on 2/7/17.
//  Copyright © 2017 Alexander Hawkins. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    var pin1 = MKPointAnnotation()
    let pin2 = MKPointAnnotation()
    let pin3 = MKPointAnnotation()
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()

    func mapTypeChanged(_ segControl: UISegmentedControl)
    {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    override func loadView() {
        
        mapView = MKMapView()
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl
            = UISegmentedControl(items: [standardString,satelliteString,hybridString])
        segmentedControl.backgroundColor
            = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
    segmentedControl.addTarget(self,action:#selector(MapViewController.mapTypeChanged(_:)),for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        let topConstraint
            = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint
            = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint
            = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
 
        pin1.coordinate = CLLocationCoordinate2DMake(38.9072, -77.0369)
        pin2.coordinate = CLLocationCoordinate2DMake(47.7511, -120.7401)
        pin3.coordinate = CLLocationCoordinate2DMake(35.2271, -80.8431)

        mapView.addAnnotation(pin1)
        mapView.addAnnotation(pin2)
        mapView.addAnnotation(pin3)

        initLocalizationButton(segmentedControl)
        initPinButton(segmentedControl)
        
        }
    
    func showLocalization(sender: UIButton!)
    {
        mapView.userTrackingMode = .follow
    }
    
    func initLocalizationButton(_ anyView: UIView!)
    {
        let localizationButton = UIButton.init(type: .system)
        localizationButton.setTitle("My Location", for: .normal)
        localizationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(localizationButton)
        
        //Constraints
        
        let topConstraint = localizationButton.topAnchor.constraint(equalTo:anyView
            .topAnchor, constant: 32 )
        let leadingConstraint = localizationButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = localizationButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        localizationButton.addTarget(self, action: #selector(MapViewController.showLocalization(sender:)), for: .touchUpInside)
    }
    
    func showPinLocations(sender: UIButton!)
    {
       
    }
    
    func initPinButton(_ anyView: UIView!)
    {
        let pinButton = UIButton.init(type: .system)
        pinButton.setTitle("Pins", for: .normal)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinButton)
        
        let topConstraint = pinButton.topAnchor.constraint(equalTo:anyView
            .topAnchor, constant: 32 )
        let leadingConstraint = pinButton.leadingAnchor.constraint(equalTo: anyView.leadingAnchor, constant : 200)
        let trailingConstraint = pinButton.trailingAnchor.constraint(equalTo: anyView.trailingAnchor, constant: 20)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true

        pinButton.addTarget(self, action: #selector(MapViewController.showPinLocations(sender:)), for: .touchUpInside)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
}

