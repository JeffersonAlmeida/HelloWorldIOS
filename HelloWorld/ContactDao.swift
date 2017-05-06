//
//  ContactDao.swift
//  HelloWorld
//
//  Created by ios7061 on 25/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import Foundation

class ContactDao: CoreDataUtil {

    static private var DATA_INSERTED_KEY: String = "data_inserted"
    
    static private var defaultDao: ContactDao!
    
    var contacts: Array<Contact>!
    
   override private init(){
        self.contacts = Array()
        super.init()
        print("PATH: \(NSHomeDirectory())}")
        self.saveInitialContacts()
        self.loadData()
    }
    
    static func get() -> ContactDao {
        if ( defaultDao == nil ){
            defaultDao = ContactDao()
        }
        return defaultDao;
    }
    
    func saveInitialContacts(){
        let defaultConfig = UserDefaults.standard
        let dataInserted = defaultConfig.bool(forKey: ContactDao.DATA_INSERTED_KEY)
        if !dataInserted {
            
            let defaultContact = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: self.persistentContainer.viewContext) as! Contact
            
            defaultContact.name = "Jefferson"
            defaultContact.address = "Rua vergueiro 3185"
            defaultContact.site = "www.mywebsite.com.br"
            defaultContact.lat = NSNumber(value: -23.5)
            defaultContact.log = NSNumber(value: -46.7) 
            defaultContact.phone = "+55114567954236"
            
            self.saveContext()
            
            defaultConfig.set(true, forKey: ContactDao.DATA_INSERTED_KEY)
            defaultConfig.synchronize()

            
        }
    }
    
    func loadData(){
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        
        do {
            self.contacts = try self.persistentContainer.viewContext.fetch(fetchRequest)
        }catch let error as NSError {
            print("Fetch falhou \(error.localizedDescription)")
        }
        
    }
    
    func newContact() -> Contact {
       return NSEntityDescription.insertNewObject(forEntityName: "Contact", into: self.persistentContainer.viewContext) as! Contact
    }
    
    func add(contact: Contact){
        contacts.append(contact)
        saveContext()
        print(contact)
    }
    
    func getAll() -> [Contact] {
        return contacts;
    }
    
    func getContactAt(position: Int) -> Contact {
        return contacts[position]
    }
    
    func removeContactAt(position: Int) {
        self.persistentContainer.viewContext.delete(contacts[position])
        contacts.remove(at: position)
        self.saveContext()
    }
    
    func contactPosition(contact: Contact) -> Int {
        return contacts.index(of: contact)!;
    }
}
