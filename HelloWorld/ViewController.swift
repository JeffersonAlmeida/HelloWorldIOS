//
//  ViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

// Form
class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var name: UITextField!;
    @IBOutlet var phone: UITextField!;
    @IBOutlet var address: UITextField!;
    @IBOutlet var site: UITextField!;
    @IBOutlet var imageView: UIImageView!;
    
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
            
            let changeButton = UIBarButtonItem(title: "Confirmar", style: .plain, target: self, action: #selector(updateContact))
            
            self.navigationItem.rightBarButtonItem = changeButton
            
        }
        
        let uiTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectPhoto(sender:)))
        imageView.addGestureRecognizer(uiTapRecognizer)
        
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
            self.contact = Contact();
        }
        
        contact?.name = self.name.text!
        contact?.phone = self.phone.text!
        contact?.address = self.address.text!
        contact?.site = self.site.text!
        contact?.image = self.imageView.image
        
        return contact!
    }

}

