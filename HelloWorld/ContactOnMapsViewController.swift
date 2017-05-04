//
//  ContactOnMapsViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 03/05/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit
import MapKit

class ContactOnMapsViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    let localizationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizationManager.requestWhenInUseAuthorization()
        
        let button = MKUserTrackingBarButtonItem(mapView: map)
        self.navigationItem.rightBarButtonItem = button

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
