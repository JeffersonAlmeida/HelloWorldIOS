//
//  ContactDao.swift
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import Foundation

class ContactDao: NSObject {

    static private var defaultDao: ContactDao!
    
    var contacts: Array<Contact>!
    
   override private init(){
        self.contacts = Array()
        super.init()
    }
    
    static func get() -> ContactDao {
        if ( defaultDao == nil ){
            defaultDao = ContactDao()
        }
        return defaultDao;
    }
    
    func add(contact: Contact){
        contacts.append(contact)
        print(contact)
    }
    
    func getAll() -> [Contact] {
        return contacts;
    }
    
    func getContactAt(position: Int) -> Contact {
        return contacts[position]
    }
    
    func removeContactAt(position: Int) {
        contacts.remove(at: position)
    }
    
    func contactPosition(contact: Contact) -> Int {
        return contacts.index(of: contact)!;
    }
}
