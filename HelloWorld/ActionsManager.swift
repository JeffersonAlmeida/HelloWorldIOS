//
//  ActionsManager.swift
//  HelloWorld
//
//  Created by ios7061 on 02/05/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

class ActionsManager {

    let contact:Contact
    var controller: UIViewController!
    
    init(contact: Contact){
        self.contact = contact
    }
    
    func showActions(controller: UIViewController){
        self.controller = controller;
        
        let uiSheetController = UIAlertController(title: self.contact.name, message: "", preferredStyle: .actionSheet )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: cancelActionCallback)
        let callContactAction = UIAlertAction(title: "Call", style: .default, handler: callContactActionCallback)
        let showContactOnMapsAction = UIAlertAction(title: "Maps", style: .default, handler: showMapCallback)
        let showWebSiteAction = UIAlertAction(title: "WebSite", style: .default, handler: showWebSiteActionCallback)
        let showWheatherAction = UIAlertAction(title: "Wheather", style: .default, handler: showWheatherActionCallback)
        
        uiSheetController.addAction(cancelAction)
        uiSheetController.addAction(callContactAction)
        uiSheetController.addAction(showContactOnMapsAction)
        uiSheetController.addAction(showWebSiteAction)
        uiSheetController.addAction(showWheatherAction)
        
        self.controller.present(uiSheetController, animated: true, completion: nil )
     
    }
    
    func cancelActionCallback(uiAlertAction: UIAlertAction){
        
    }
    
    func callContactActionCallback(uiAlertAction: UIAlertAction){
        
    }
    
    func showMapCallback(uiAlertAction: UIAlertAction){
        
    }
    
    func showWebSiteActionCallback(uiAlertAction: UIAlertAction){
    
    }
    
    func showWheatherActionCallback(uiAlertAction: UIAlertAction){
        let wheatherViewController = controller.storyboard?.instantiateViewController(withIdentifier: "wheatherViewController") as! ForecastViewController
        wheatherViewController.contact = self.contact
        controller.navigationController?.pushViewController(wheatherViewController, animated: true)
    }

}
