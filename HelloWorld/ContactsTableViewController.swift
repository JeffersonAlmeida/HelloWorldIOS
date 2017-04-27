//
//  ContactsTableViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 26/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, FormularioContatoViewControllerDelegate {
    
    let cellIndentifier = "cell"
    
    var contactDao: ContactDao

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    required init?(coder aDecoder: NSCoder){
        self.contactDao = ContactDao.get();
        super.init(coder: aDecoder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactDao.getContactAt(position: indexPath.row)
        print(contact)
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let form = storyboard.instantiateViewController(withIdentifier: "Form-Contato") as! ViewController
        
        form.contact = contact
        
        form.delegate=self as! FormularioContatoViewControllerDelegate
        
        self.navigationController?.pushViewController(form, animated: true)
        
    }
    
    func contactUpdated(contact: Contact ) {
        print("contato atualizado: \(contact.name!)");
    }
    
    func contactAdded(contact: Contact ) {
        print("contato adicionado: \(contact.name!)");
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FormSegue" {
            if let form  = segue.destination as? ViewController {
                form.delegate = self as! FormularioContatoViewControllerDelegate
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contactDao.getAll().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier )

        if ( cell == nil ) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIndentifier )
        }
        
        let contact = contactDao.getContactAt(position: indexPath.row )
        cell?.textLabel!.text = contact.name

        return cell!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
  

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
