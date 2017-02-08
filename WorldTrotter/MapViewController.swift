//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Hawkins on 2/7/17.
//  Copyright © 2017 Alexander Hawkins. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    
    func mapTypeChanged(_segControl: UISegmentedControl) {
        switch _segControl.selectedSegmentIndex {
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
        
        //segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
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

        }
    
    override func viewDidAppear(_ animated: Bool) {
        let date = Date()
        let calender = Calendar.current
        let hour = calender.component(.hour, from: date as Date)
        
        if hour > 6 || hour < 17 {
            self.view.backgroundColor=UIColor.darkGray
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
    }
}

