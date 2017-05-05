//
//  ContactOnMapsViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 03/05/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit
import MapKit

class ContactOnMapsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var contacts: [Contact] = Array()
    let contactDao = ContactDao.get()
    
    let localizationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localizationManager.requestWhenInUseAuthorization()
        
        let button = MKUserTrackingBarButtonItem(mapView: map)
        self.navigationItem.rightBarButtonItem = button
        
        self.map.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
           return nil
        }
        
        let identifier = "pin"
        
        var pin:MKPinAnnotationView
        if let reusablePin = map.dequeueReusableAnnotationView(withIdentifier:identifier) as? MKPinAnnotationView {
            pin = reusablePin
        }else{
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contact = annotation as? Contact {
            pin.pinTintColor = UIColor.red
            pin.canShowCallout = true
            
//            let frame = CGRect(x:0.0,y:0.0,width:32.0,heigh: 32.0)
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let imageContact = UIImageView(frame: frame)
            
            imageContact.image = contact.image
            pin.leftCalloutAccessoryView = imageContact
        }
        
        return pin
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contacts = contactDao.getAll()
        if !contacts.isEmpty {
            map.addAnnotations(contacts)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        contacts = contactDao.getAll()
        if !contacts.isEmpty {
            map.removeAnnotations(contacts)
        }
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
