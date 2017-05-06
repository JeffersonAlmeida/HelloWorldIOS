//
//  ViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit
import CoreLocation

// Form
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var name: UITextField!;
    @IBOutlet weak var phone: UITextField!;
    @IBOutlet weak var address: UITextField!;
    @IBOutlet weak var site: UITextField!;
    @IBOutlet weak var imageView: UIImageView!;
    @IBOutlet weak var log: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var pinMapButton: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var contact: Contact?
    
    var delegate: FormularioContatoViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contact != nil {
            name.text = contact?.name
            phone.text = contact?.phone
            address.text = contact?.address
            site.text = contact?.site
            imageView.image = contact?.image
            lat.text = contact?.lat.description
            log.text = contact?.log.description
            
            let changeButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(updateContact))
            
            self.navigationItem.rightBarButtonItem = changeButton
            
        }
        
        let uiTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoto(sender:)))
        imageView.addGestureRecognizer(uiTapRecognizer)
        
    }
    
    @IBAction func onClickpinMapButton(sender: UIButton){
        
        let geocoder = CLGeocoder()
        let addressText = self.address.text!
        if !addressText.isEmpty {
            
            indicator.startAnimating()
            geocoder.geocodeAddressString(self.address.text!) { (result, error) in
                if error == nil && (result?.count)! > 0 {
                    let placeMark = result![0]
                    let location = placeMark.location!.coordinate
                    self.lat.text = location.latitude.description
                    self.log.text = location.longitude.description
                } else {
                    print("error" + error.debugDescription)
                }
                
                self.indicator.stopAnimating()
            }
        }else{
            let alert = UIAlertController(title: "Empty Address", message: "Type an Address", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func selectPhoto(sender: AnyObject){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            // Camera is Available
        }else{
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        
        if let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func updateContact(){
        getContactFromView()
        self.delegate?.contactUpdated(contact: contact!)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonClicked(){
        
        contact = getContactFromView()
    
        ContactDao.get().add(contact: contact!)
        
        self.delegate?.contactAdded(contact: contact!)
        
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    func getContactFromView() -> Contact {
        
        if contact == nil {
            self.contact = ContactDao.get().newContact()
        }
        
        contact?.name = self.name.text!
        contact?.phone = self.phone.text!
        contact?.address = self.address.text!
        contact?.site = self.site.text!
        contact?.image = self.imageView.image
        
        if let latDouble = Double(self.lat.text!) {
             contact?.lat = latDouble as NSNumber
        }
        
        
        if let logDouble = Double(self.log.text!) {
            contact?.log = logDouble as NSNumber
        }
        
        return contact!
    }

}

