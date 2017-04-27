//
//  ViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

// Form
class ViewController: UIViewController {
    
    @IBOutlet var name: UITextField!;
    @IBOutlet var phone: UITextField!;
    @IBOutlet var address: UITextField!;
    @IBOutlet var site: UITextField!;
    
    var contact: Contact
    
    var delegate: FormularioContatoViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder){
        contact = Contact()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if contact != nil {
            name.text = contact.name
            phone.text = contact.phone
            address.text = contact.address
            site.text = contact.site
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonClicked(){
        
        contact = getContactFromView()
    
        ContactDao.get().add(contact: contact)
        
        self.delegate?.contactAdded(contact: contact)
        
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    func getContactFromView() -> Contact {
        let contact = Contact();
        contact.name = self.name.text!;
        contact.phone = self.phone.text!;
        contact.address = self.address.text!;
        contact.site = self.site.text!;
        return contact;
    }

}

