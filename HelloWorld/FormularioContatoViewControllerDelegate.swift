//
//  FormularioContatoViewControllerDelegate.swift
//  HelloWorld
//
//  Created by ios7061 on 27/04/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import Foundation

protocol FormularioContatoViewControllerDelegate {
    func contactUpdated(contact: Contact)
    func contactAdded(contact: Contact)
}
