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
        
        let segmentedControl
            = UISegmentedControl(items: ["Standard", "Hybrid" , "Satellite"])
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
        
        initLocalizationButton(segmentedControl)
        
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

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
}

