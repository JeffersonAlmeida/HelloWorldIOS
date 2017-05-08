//
//  ForecastViewController.swift
//  HelloWorld
//
//  Created by ios7061 on 08/05/17.
//  Copyright © 2017 ios7061. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var wheatherCondition: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

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
